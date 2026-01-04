// variables passées au mapper

local claims   = std.extVar('claims');   // claims OIDC de Google
local subject  = std.extVar('subject');  // sub (id externe)
local provider = std.extVar('provider'); // 'google', etc.

{
  identity: {
    // "schema_id" si nécessaire, sinon Kratos utilise celui par défaut
    // schema_id: "default",

    traits: {
      // /!\ ATTENTION /!\ : les clés ci dessousdoivent exister dans le schéma JSON d’identité Kratos
      email: if std.objectHas(claims, 'email') then claims.email else error 'Missing email claim from OIDC provider',

//      name:        (claims.name)       + "",  // cast en string par sécurité
//      avatar_url:  (claims.picture)    + "",
    },
  },

  // Optionnel : on peut aussi renvoyer metadata_public / metadata_admin
  // metadata_public: { raw_google_claims: claims },
}
