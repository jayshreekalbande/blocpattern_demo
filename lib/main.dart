import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:blocpatterntest/data/repositories/userData_repository.dart';
import 'package:blocpatterntest/bloc/user_bloc/user_bloc.dart';
import 'package:blocpatterntest/UI/screens/home_page.dart';
import 'package:blocpatterntest/UI/screens/user_details.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return 
    MultiBlocProvider(
        providers: [
          BlocProvider<UserBloc>(
            create: (BuildContext context) => UserBloc(),
          ),
        ],
        child:MaterialApp(
      routes: {
            HomePage.route: (context) => HomePage(),
            
      },
      title: 'GitHub Demo',
          theme: ThemeData(
            fontFamily: "Gafata",
            primarySwatch: Colors.deepPurple,
          ),
          home: BlocProvider(
            create: (context) => UserBloc(repository: UserRepositoryImpl()),
            child: HomePage(),
          ),
          
          debugShowCheckedModeBanner: false,
        ));
  }
}



