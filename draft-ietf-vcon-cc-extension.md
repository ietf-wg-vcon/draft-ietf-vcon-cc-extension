---
title: "The JSON vCon - Contact Center Extension"
abbrev: "vCon CC Extension"
category: std

docname: draft-ietf-vcon-cc-extension-latest

submissiontype: IETF  # also: "independent", "IAB", or "IRTF"
number:
date:
consensus: true
v: 3
area: "Applications and Real-Time"
workgroup: "Virtualized Conversations"
keyword:
 - conversation
 - vcon
 - CDR
 - call detail record
 - call meta data
 - call recording
 - email thread
 - text conversation
 - video recording
 - video conference
 - conference recording
venue:
  group: "Virtualized Conversations"
  type: "Working Group"
  mail: "vcon@ietf.org"
  arch: "https://mailarchive.ietf.org/arch/browse/vcon/"
  github: "ietf-wg-vcon/draft-ietf-vcon-cc-extension"
  latest: "https://ietf-wg-vcon.github.io/draft-ietf-vcon-cc-extension/draft-ietf-vcon-cc-extension.html"

author:
 -
    fullname: Daniel G Petrie
    organization: SIPez LLC
    email: dan.ietf@sipez.com

normative:

  JSON: RFC8259

  UUID: I-D.draft-peabody-dispatch-new-uuid-format

  VCON-CORE: I-D.draft-vcon-vcon-core

informative:

  vCon-white-paper:
    target: https://github.com/vcon-dev/vcon/blob/main/docs/vCons_%20an%20Open%20Standard%20for%20Conversation%20Data.pdf
    title: "vCon: an Open Standard for Conversation Data"
    author:
      -
        ins: T. Howe
        name: Thomas Howe
        org: STROLID Inc.
      -
        ins: D. Petrie
        name: Daniel Petrie
        org: SIPez LLC
      -
        ins: M. Lieberman
        name: Mitch Lieberman
        org: Conversational X
      -
        ins: A. Quayle
        name: Alan Quayle
        org: TADHack and TADSummit

  CDR:
    target: https://www.itu.int/rec/T-REC-Q.825
    title: "Recommendation Q.825: Specification of TMN applications at the Q3 interface: Call detail recording"
    author:
      org: ITU
      date: 1998

  PY-VCON:
    target: https://github.com/py-vcon/py-vcon
    title: "Python open source vCon command line interface, library and workflow server"

--- abstract

A vCon is container for data and information relating to a human conversation.
This document defines an extension for the JSON vCon schema in support of call, support or contact center application of the vCon conversational data exchange format.

--- middle

# Introduction

This document adds a number of new parameters to the Party Object and the Dialog Object defined as part of the JSON vCon schema in [VCON-CORE].
The vCon parameters defined in this document have been determined to be need and are specific to the contact center uses of vCon.
The general framework and requirements for defining an extension to the JSON vCon schema are defined in [VCON-CORE].

# Conventions and Definitions

{::boilerplate bcp14-tagged}

## Terminology

* analysis - analysis, transformations, summary, sentiment, or translation typically of the dialog data

* conversation - an exchange of communication using text, audio or video medium between at least one human and one or more bots or humans

* de-identification - removal of all information that could identify a party in a conversation.  This includes PII as well as audio and video recordings.  Voice recordings might be re-vocalized with a different speaker.

* dialog - the captured conversation in its original form (e.g. text, audio or video)

* encrypted form - encrypted JWE document with the JWS signed vCon form contained in the ciphertext

* file - a data block either included or referenced in a vCon

* object - JSON object containing key and value pairs

* parameter - JSON key and value pair

* party - an observer or participant to the conversation, either passive or active

* payload - the contents or bytes that make up a file

* PII - Personal Identifiable Information

* PII masked - may include voice recordings, but PII is removed from transcripts and recordings (audio and video).

* vCon - container for conversational information

* vCon instance - a vCon populated with data for a specific conversation

* vCon instance version - a single version of an instance of a conversation, which may be modified to redact or append additional information  forming a subsequent vCon instance version

* vCon syntax version - the version for the data syntax used for form a vCon

* signed form - JWS signed document with the unsigned vCon form contained in the payload

## JSON Notation

This document uses the same JSON notation that is used in [VCON-CORE].
For the ease of documentation, the convention for JSON notation used in this document is copied from section 2.2 of [VCON-CORE].

* "String" - a JSON string type

* "A\[\]" and array of values of type A.

All parameters are assumed to be mandatory unless other wise noted.

Objects or arrays with no or null values MAY be excluded from the vCon.

# vCon JSON Object

This vCon extension adds a new extensions parameter name value token.
The string token "CC" should be included in the extensions array of the vCon Object.
It is not required that consumers of vCons with the **CC** extension content support this extension.
It does not change the semantics or remove any parameters form the core vCon schema.
There is no need to list the CC extension name in the **must_support** parameter.

## Party Object

This vCon extension adds the following new parameters to the Party Object in support of Contact Center use cases.

### role

The role that the participant played in the conversation.
In a call center there are roles: such as: agents, customer, supervisor and specialist.
In conferences there are roles: host, cohost, speaker, panelist, participant and other roles.
The role parameter provides the ability to label the role that the part played in the conversation.

* role: "String" (optional)

The following values for the role parameter MAY be used:

  + "agent"
  + "customer"
  + "supervisor"
  + "sme" (for subject mater expert)
  + "thirdparty"

Other values for the role parameter MAY also be used.

### contact_list {#contact_list}

In a contact center scenario, the conversation with this party may be part of a larger effort of contacting a group of parties, individually or perhaps in groups.
It is sometimes useful to reference the list from which this party was included.
The contact_list may be used as a label for foreign key reference to the contact list that this party was on.

* contact_list "String" (optional)

## Dialog Object

This vCon extension adds the following new parameters to the Dialog Object in support of Contact Center use cases.

### campaign

In a contact center scenario, a dialog may be initiated as part of a campaign or set of dialogs initiated with a common goal or focus or to be handled or treated in a specific way.
The campaign parameter is string that may be used as a label or foreign key in reference to an external specification for how the communication is to be initiated, handled or treated.
In some case it may be appropriate to attached the campaign data as an Attachment Object.

* campaign: "String" (optional)

### interaction_type {#interaction_type}

* interaction_type "String" (optional)

TODO: add enumerated values from JDR

### interaction_id {#interaction_id}

TODO: Is this different from RFC7989 session ID (session_id in core)?

In a contact center scenario, interactions with a party are often labeled with an identifier.
In some case the interaction is contained in a single dialog.
In others there may be multiple dialogs (e.g. messages or calls) that are all part of a single interaction.
There may also be many interactions for a single conversation or vCon.
The interaction parameter is used as a label or foreign key in reference to the interaction ID.

* interaction_id "String" (optional)

### skill

A contact center may service multiple purposes or customers.
In this scenario it is important to label the conversation segment or dialog.
The agent or automata which services the dialog are required to have a specific skill.
To facilitate this in a vCon dialog, the skill parameter is provided.
The string values of the skill parameter are contact center specific.

* skill "String" (optional)


# Security Considerations

Security considerations are covered in the [VCON-CORE] document.
This extension to vCon adds no additional security concerns.

# IANA Considerations

## vCon JSON Registry Additions

### vCon Extensions Names Registry

The following extension name is added to the vCon Extensions Names Registry.

| Extension Name | Extension Description | Change Controller | Specification Document(s):
| --- | --- | --- | --- |
| CC | Contact Center | IESG | [](#vcon-json-object) RFC XXXX |


### Parties Object Parameter Names Registry

The following defines additional values for the vCon Parties Object Parameter Names Registry.

| Parameter Name | Parameter Description | Change Controller | Specification Document(s) |
| --- | --- | --- | --- |
| role | agent party role | IESG | [](#role) RFC XXXX |
| contact_list | contact_list including this party | IESG | [](#contact_list) RFC XXXX |


### Dialog Object Parameter Names Registry

The following defines the initial values for the vCon Dialog Object Parameter Names Registry.

| Parameter Name | Parameter Description | Change Controller | Specification Document(s) |
| --- | --- | --- | --- |
| campaign | campaign to which dialog is part of | IESG | [](#campaign) RFC XXXX |
| interaction_type | dialog interaction type | IESG | [](#interaction_type) RFC XXXX |
| interaction_id | dialog interaction id | IESG | [](#interaction_id) RFC XXXX |
| skill | required skill | IESG | [](#skill) RFC XXXX |

# Contact Center Use Cases

TODO: insert draft-rosenberg-vcon-cc-usecases here

# Example vCons

TODO

# Acknowledgments
{:numbered="false"}

* Thank you to Thomas McCarthy-Howe for inventing the concept of a vCon and the many discussions that we had while this concept was developed into reality.
* Thank you to Jonathan Rosenberg and Andrew Siciliano for their input to the vCon container requirements in the form of I-D: draft-rosenberg-vcon-cc-usecases.
* Thank you to Rohan Mahy for his help in exploring the CDDL schema and CBOR format for vCon.
* The examples in this document were generated using the command line interface (CLI) from the py-vcon [PY-VCON] python open source project.
* Thank you to Steve Lasker for formatting and spelling edits.

