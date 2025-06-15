import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:med_parser/common_widgets/primary_button.dart';
import 'package:med_parser/common_widgets/responsive_center.dart';
import 'package:med_parser/constants/app_sizes.dart';
import 'package:med_parser/features/onboarding/presentation/onboarding_controller.dart';
import 'package:med_parser/l10n/generated/app_localizations.dart/app_localizations.dart';
import 'package:med_parser/routing/app_router.dart';
import 'package:med_parser/utils/number_extension.dart';

class OnboardingScreen extends ConsumerWidget {
  const OnboardingScreen({super.key});

  ///TODO Translate
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(onboardingControllerProvider);
    final l10n = AppLocalizations.of(context);

    return Scaffold(
      body: ResponsiveCenter(
        maxContentWidth: 450,
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Track your time.\nBecause time counts.',
              style: Theme.of(context).textTheme.headlineSmall,
              textAlign: TextAlign.center,
            ),
            Sizes.spacingL.hSpace,
            SvgPicture.asset(
              'assets/time-tracking.svg',
              width: 200,
              height: 200,
              semanticsLabel: 'Time tracking logo',
            ),
            Sizes.spacingL.hSpace,
            PrimaryButton(
              text: l10n.getStarted,
              isLoading: state.isLoading,
              onPressed: state.isLoading
                  ? null
                  : () async {
                      await ref
                          .read(onboardingControllerProvider.notifier)
                          .completeOnboarding();
                      if (context.mounted) {
                        context.go(AppRoute.speechToText.name);
                      }
                    },
            ),
          ],
        ),
      ),
    );
  }
}
