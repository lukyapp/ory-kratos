// variables passées au mapper

local claims   = std.extVar('claims');   // claims OIDC de Google
local subject  = std.extVar('subject');  // sub (id externe)
local provider = std.extVar('provider'); // 'google', etc.
local resolved_name =
  if std.objectHas(claims, 'name') then claims.name
  else if std.objectHas(claims, 'given_name') && std.objectHas(claims, 'family_name')
  then claims.given_name + ' ' + claims.family_name
  else if std.objectHas(claims, 'given_name') then claims.given_name
  else null;
local resolved_picture =
  if std.objectHas(claims, 'picture') then claims.picture
  else null;

{
  identity: {
    // "schema_id" si nécessaire, sinon Kratos utilise celui par défaut
    // schema_id: "default",

    traits: {
      // /!\ ATTENTION /!\ : les clés ci dessousdoivent exister dans le schéma JSON d’identité Kratos
      email: if std.objectHas(claims, 'email') then claims.email else error 'Missing email claim from OIDC provider',
    }
    + if resolved_name != null then { name: resolved_name } else {}
    + if resolved_picture != null then { picture: resolved_picture } else {},
  },

  // Optionnel : on peut aussi renvoyer metadata_public / metadata_admin
  // metadata_public: { raw_google_claims: claims },
}
