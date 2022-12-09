import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';
import '../../../auth/auth_state.dart';

List<SingleChildWidget> providers = [
  ChangeNotifierProvider(
    create: (context) => AuthState(),
    lazy: false,
  )
];