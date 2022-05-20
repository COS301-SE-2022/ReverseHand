#!/usr/bin/env python3
# This code is used to generate actiosn for the redux pattern
# Input should be in snake case, don't add the action at the end

# getting input and manipulating data
action_name = input("Enter action name: ")

filename = action_name + "_action.dart"
words = action_name.split('_')

class_name = ""
for w in words:
    class_name += w.capitalize()

class_name += "Action"

print("Creating {}".format(class_name))

# writing to file
with open("./lib/actions/{}".format(filename), "w") as file:
    lines = [
        "import '../app_state.dart';\n",
        "import 'package:amplify_flutter/amplify_flutter.dart';\n",
        "import 'package:async_redux/async_redux.dart';\n\n",
        "class {} extends ReduxAction<AppState> ".format(class_name),
        "{\n",
        "\t@override\n",
        "\tFuture<AppState?> reduce() async {}\n",
        "}\n"
    ]
    
    file.writelines(lines)