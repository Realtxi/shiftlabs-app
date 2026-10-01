import "package:flutter_test/flutter_test.dart";
import "package:shiftlabs_app/data/repositories/tool_repository.dart";
import "package:shiftlabs_app/data/services/storage_service.dart";
import "package:shiftlabs_app/main.dart";
import "package:shiftlabs_app/ui/view_models/app_view_model.dart";

void main() {
  testWidgets("ShiftlabsApp smoke test", (WidgetTester tester) async {
    final storageService = StorageService();
    final toolRepository = ToolRepository(storageService: storageService);
    final viewModel = AppViewModel(
      toolRepository: toolRepository,
      storageService: storageService,
    );

    await tester.pumpWidget(ShiftlabsApp(viewModel: viewModel));
    expect(find.text("Shiftlabs"), findsWidgets);
  });
}
