import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:notizapp/cubit/archive_notes_cubit/archive_notes_cubit.dart';

import 'package:notizapp/cubit/notes_cubit/notes_cubit.dart';
import 'package:notizapp/cubit/searchfield_cubit/searchfield_cubit.dart';
import 'package:notizapp/cubit/theme_cubit/theme_cubit.dart';
import 'package:notizapp/view/pages/all_notes.dart';

import 'package:notizapp/view/screens/responsive_layout.dart';
import 'package:notizapp/view/screens/responsive_screens/desktop_screen.dart';
import 'package:path_provider/path_provider.dart';

import 'view/screens/responsive_screens/mobile_screen.dart';
import 'view/screens/responsive_screens/tablet_screen.dart';

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
        BlocProvider<ArchiveNotesCubit>(
          lazy: false,
          create: ((context) => ArchiveNotesCubit()),
        ),
      ],
      child: Builder(builder: (context) {
        return const MaterialApp(
          debugShowCheckedModeBanner: false,
          home: AllNotesPage(),
        );
      }),
    );
  }
}
