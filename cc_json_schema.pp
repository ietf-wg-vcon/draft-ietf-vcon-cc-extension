{
  "$schema": "http://json-schema.org/draft-07/schema#",
  "$id": "https://ietf.org/vcon/schemas/cc-extension.json",
  "title": "vCon Contact Center (cc) Extension",
  "description": "Supplemental JSON schema for the parameters def
    ined by the vCon Contact Center (cc) extension, RFCXXXX. This
     schema is applied in addition to the core vCon schema; it co
    nstrains only the parameters added by this extension and leav
    es all other parameters to the core schema. The text of this 
    document is normative; this schema is informational.",
  "type": "object",
  "properties": {
    "parties": {
      "type": "array",
      "items": {
        "$ref": "#/definitions/PartyCcExtension"
      }
    },
    "dialog": {
      "type": "array",
      "items": {
        "$ref": "#/definitions/DialogCcExtension"
      }
    }
  },
  "definitions": {
    "PartyCcExtension": {
      "type": "object",
      "description": "Contact center parameters added to the core
         Party Object",
      "properties": {
        "role": {
          "type": "string",
          "description": "Role played by the party in the contact
             center interaction"
        },
        "contact_list": {
          "type": "string",
          "description": "Identifier of the contact or dialing li
            st from which the party was contacted"
        }
      }
    },
    "DialogCcExtension": {
      "type": "object",
      "description": "Contact center parameters added to the core
         Dialog Object",
      "properties": {
        "interaction_type": {
          "type": "string",
          "description": "Type of contact center interaction repr
            esented by the dialog"
        },
        "interaction_id": {
          "type": "string",
          "description": "Identifier correlating the dialog with 
            the originating contact center system"
        },
        "campaign": {
          "type": "string",
          "description": "Identifier of the campaign associated w
            ith the dialog"
        },
        "skill": {
          "type": "array",
          "items": {
            "type": "string"
          },
          "description": "Set of skill associated with the dialog
            "
        }
      }
    }
  }
}

