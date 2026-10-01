import "package:flutter/material.dart";
import "core/theme/app_theme.dart";
import "data/repositories/tool_repository.dart";
import "data/services/storage_service.dart";
import "ui/screens/favorites_screen.dart";
import "ui/screens/settings_screen.dart";
import "ui/screens/studio_screen.dart";
import "ui/screens/tools_catalog_screen.dart";
import "ui/view_models/app_view_model.dart";
import "ui/widgets/adaptive_scaffold.dart";

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final storageService = StorageService();
  final toolRepository = ToolRepository(storageService: storageService);
  final viewModel = AppViewModel(
    toolRepository: toolRepository,
    storageService: storageService,
  );

  await viewModel.initialize();

  runApp(ShiftlabsApp(viewModel: viewModel));
}

class ShiftlabsApp extends StatelessWidget {
  final AppViewModel viewModel;

  const ShiftlabsApp({super.key, required this.viewModel});

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: viewModel,
      builder: (context, _) {
        return MaterialApp(
          title: "Shiftlabs Tools & Studio v2.0",
          debugShowCheckedModeBanner: false,
          theme: AppTheme.darkTheme,
          home: ShiftlabsMainScreen(viewModel: viewModel),
        );
      },
    );
  }
}

class ShiftlabsMainScreen extends StatelessWidget {
  final AppViewModel viewModel;

  const ShiftlabsMainScreen({super.key, required this.viewModel});

  @override
  Widget build(BuildContext context) {
    Widget currentBody;

    switch (viewModel.currentTabIndex) {
      case 0:
        currentBody = ToolsCatalogScreen(viewModel: viewModel);
        break;
      case 1:
        currentBody = StudioScreen(viewModel: viewModel);
        break;
      case 2:
        currentBody = FavoritesScreen(viewModel: viewModel);
        break;
      case 3:
        currentBody = SettingsScreen(viewModel: viewModel);
        break;
      default:
        currentBody = ToolsCatalogScreen(viewModel: viewModel);
    }

    return AdaptiveScaffold(
      viewModel: viewModel,
      body: currentBody,
    );
  }
}
