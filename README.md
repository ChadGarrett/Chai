# Chai

This is an app I started developing to track a few things around the house, such as:
- Debit orders
- Prepaid electricity purchases
- Contributions to savings
- Gym visits
- And probably a lot more in the future

I haven't published the API that this app uses yet as it's incomplete and very much a work in progress. The models are simple and any basic REST API could be used.

---

## Features

 - Adding and editing debit orders
 - Viewing the total debit orders
 - Search and sort debit orders
 - Logging prepaid electricity purchases
 - Logging contributions to savings accounts

### Technical features

- Uses Realm to locally store all added objects
- When syncing data from an API the data is loaded into Realm which then notifies the UI for display.

## Possible future feature ideas

- Reminders
- User accounts so households can share the same information
- Gym visit tracker / basic exercise tracking

## Setup and development

Requires Xcode 12.5+ and Swift 5.3.

Clone the repo, install the pods by running `pod install` and run the target. 

---

### Known bugs:

 - Lots, probably
