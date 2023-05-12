import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:synew_gym/app_theme.dart';
import 'package:synew_gym/blocs/auth/auth_bloc.dart';
import 'package:synew_gym/blocs/auth_landing/auth_landing_cubit.dart';
import 'package:synew_gym/blocs/cart/cart_cubit.dart';
import 'package:synew_gym/blocs/category_toggle/category_cubit.dart';
import 'package:synew_gym/blocs/chat/chat_bloc.dart';
import 'package:synew_gym/blocs/nutrition/nutrition_bloc.dart';
import 'package:synew_gym/blocs/product/product_bloc.dart';
import 'package:synew_gym/blocs/profile/profile_cubit.dart';
import 'package:synew_gym/blocs/signin/signin_cubit.dart';
import 'package:synew_gym/blocs/signup/signup_cubit.dart';
import 'package:synew_gym/blocs/tab_bar/tab_bar_cubit.dart';
import 'package:synew_gym/blocs/workout/workout_cubit.dart';
import 'package:synew_gym/build_routes.dart';
import 'package:synew_gym/pages/splash_page.dart';
import 'package:synew_gym/repositories/auth_repository.dart';
import 'package:synew_gym/repositories/message_repository.dart';
import 'package:synew_gym/repositories/nutrition_repository.dart';
import 'package:synew_gym/repositories/shop_repository.dart';
import 'package:synew_gym/repositories/user_repository.dart';
import 'package:synew_gym/services/nutrition_api_services.dart';
import 'package:synew_gym/services/sanity_api_services.dart';
import '.env';
import 'firebase_options.dart';
import 'package:flutter_stripe/flutter_stripe.dart';

final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeFirebase();
  setPortraitOrientation();
  Stripe.publishableKey = PUBLIC_KEY;
  runApp(const MyApp());
}

Future<void> initializeFirebase() async {
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
}

void setPortraitOrientation() {
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<AuthRepository>(
          create: (context) => AuthRepository(
            firebaseAuth: _firebaseAuth,
            firebaseFirestore: _firebaseFirestore,
          ),
        ),
        RepositoryProvider<UserRepository>(
          create: (context) =>
              UserRepository(_firebaseFirestore, _firebaseAuth),
        ),
        RepositoryProvider<MessageRepository>(
          create: (context) => MessageRepository(_firebaseFirestore),
        ),
        RepositoryProvider<NutritionRepository>(
          create: (context) => NutritionRepository(
            nutritionApiServices: NutritionApiServices(),
          ),
        ),
        RepositoryProvider<ShopRepository>(
          create: (context) => ShopRepository(
            sanityApiServices: SanityApiServices(),
          ),
        ),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider<AuthBloc>(
            create: (context) =>
                AuthBloc(authRepository: context.read<AuthRepository>()),
          ),
          BlocProvider<AuthLandingCubit>(
            create: (context) => AuthLandingCubit(
                authRepository: context.read<AuthRepository>()),
          ),
          BlocProvider<SignInCubit>(
            create: (context) =>
                SignInCubit(authRepository: context.read<AuthRepository>()),
          ),
          BlocProvider<SignUpCubit>(
            create: (context) =>
                SignUpCubit(authRepository: context.read<AuthRepository>()),
          ),
          BlocProvider<ProfileCubit>(
            create: (context) =>
                ProfileCubit(profileRepository: context.read<UserRepository>()),
          ),
          BlocProvider<TabBarCubit>(
            create: (context) => TabBarCubit(),
          ),
          BlocProvider<WorkoutCubit>(
            create: (context) => WorkoutCubit(
              profileCubit: context.read<ProfileCubit>(),
            ),
          ),
          BlocProvider<ChatBloc>(
              create: (context) => ChatBloc(
                    messageRepository: context.read<MessageRepository>(),
                  )),
          BlocProvider<NutritionBloc>(
            create: (context) => NutritionBloc(
              nutritionRepository: context.read<NutritionRepository>(),
            ),
          ),
          BlocProvider<ProductBloc>(
            create: (context) => ProductBloc(
              shopRepository: context.read<ShopRepository>(),
            ),
          ),
          BlocProvider<CategoryCubit>(
            create: (context) => CategoryCubit(),
          ),
          BlocProvider<CartCubit>(
            create: (context) => CartCubit(),
          ),
        ],
        child: MaterialApp(
          title: 'Hustlers',
          key: key,
          theme: AppTheme.light(),
          darkTheme: AppTheme.dark(),
          themeMode: ThemeMode.dark,
          onGenerateRoute: buildRoutes,
          debugShowCheckedModeBanner: false,
          debugShowMaterialGrid: false,
          showPerformanceOverlay: false,
          showSemanticsDebugger: false,
          home: const SplashPage(),
        ),
      ),
    );
  }
}
