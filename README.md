# my_state_management

Implement new state management package: provider

## Getting Started

Run command: `flutter pub get`

Run command: `flutter run`

- Check log in Terminal to see which widgets is rendered or re-rendered.
- Tap on buttons to change and re-render related widgets.
- There are 2 user screens: Buyer and Seller screens that use the same user provider type: UserProvider. They just use different tags.

## Support

- Listen single value, multiple values to re-render listenable widget.
- Support listening changing List of Object to re-render listenable widget.
- Support create multiple state instances with the same type. Just use `tag` to distingush between them.
- Support auto disposing (default) or keep state alive after closing screen.
- Support sync, async changing state.