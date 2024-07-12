import 'package:flutter/widgets.dart';
import 'package:open_api_chat_gpt/core/theme/pallete/pallete.dart';
import 'package:open_api_chat_gpt/feature/chat_gpt/presentation/feature_box.dart';

class FeatureList extends StatelessWidget {
  const FeatureList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        FeatureBox(
          color: Pallete.firstSuggestionBoxColor,
          headerText: "chatGpt",
          descriptionText:
              "Performing hot restart..3.0sRestarted application in 3,046ms.No observables detected in the build method of Observer",
        ),
        FeatureBox(
          color: Pallete.secondSuggestionBoxColor,
          headerText: "Dall-E",
          descriptionText:
              "Performing hot restart..3.0sRestarted application in 3,046ms.No observables detected in the build method of Observer",
        ),
        FeatureBox(
          color: Pallete.thirdSuggestionBoxColor,
          headerText: "Smart Voice Assistant",
          descriptionText:
              "Performing hot restart..3.0sRestarted application in 3,046ms.No observables detected in the build method of Observer",
        ),
      ],
    );
  }
}
