# Redux Pattern Library
## Description
This library contains the code for the redux pattern. The redux pattern being used is not a 'true' redux pattern as instead of middleware we are using asynchronous reducers in place.
## Structure
- redux_comp.dart - exports necessary files
- app_state.dart - the store for the pattern
- actions - holds or the actions/reducers as they are bundled together
- models - holds the different models used such as a UserModel. Can have sub folders if necessary
## Conventions
- All action files must be prefixed by _action.dart
- All model files must be prefixed by _model.dart
- All action classes must be prefixed by Action
- All model classes must be prefixed by Model
## Other
Amplify is initialized here