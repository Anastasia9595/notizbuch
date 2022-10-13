import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

import 'package:notizapp/cubit/notes_cubit/notes_cubit.dart';
import 'package:notizapp/cubit/searchfield_cubit/searchfield_cubit.dart';
import 'package:notizapp/cubit/theme_cubit/theme_cubit.dart';
import 'package:notizapp/view/home.dart';
import 'package:path_provider/path_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final storage = await HydratedStorage.build(
    storageDirectory: await getApplicationDocumentsDirectory(),
  );
  HydratedBlocOverrides.runZoned(
    () => runApp(const MyApp()),
    storage: storage,
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<NotesCubit>(
          create: ((context) => NotesCubit()),
        ),
        BlocProvider<SearchfieldCubit>(
          create: ((context) => SearchfieldCubit()),
        ),
        BlocProvider<ThemeCubit>(
          create: ((context) => ThemeCubit()),
        ),
      ],
      child: Builder(builder: (context) {
        return MaterialApp(debugShowCheckedModeBanner: false, home: const Homepage());
      }),
    );
  }
}
