import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

import 'package:path_provider/path_provider.dart';

import 'business_logic/cubits/trash_notes_cubit/trash_notes_cubit.dart';
import 'business_logic/cubits/favorites_cubit/favorites_cubit.dart';
import 'business_logic/cubits/notes_cubit/notes_cubit.dart';
import 'business_logic/cubits/searchfield_cubit/searchfield_cubit.dart';
import 'business_logic/cubits/theme_cubit/theme_cubit.dart';
import 'presentation/view/screens/responsive_screens/mobile_screen.dart';

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
    precacheImage(const AssetImage('assets/background.jpg'), context);
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
        BlocProvider<TrashNotesCubit>(
          lazy: false,
          create: ((context) => TrashNotesCubit()),
        ),
        BlocProvider<FavoritesCubit>(
          create: ((context) => FavoritesCubit()),
        ),
      ],
      child: Builder(builder: (context) {
        return const MaterialApp(
          debugShowCheckedModeBanner: false,
          home: MobileScreen(),
        );
      }),
    );
  }
}
