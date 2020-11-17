import 'package:bloc/bloc.dart';
import 'package:ieeecrop/pages/about_us.dart';
import 'package:ieeecrop/pages/history.dart';
import 'package:ieeecrop/pages/Profile_page.dart';
import 'package:ieeecrop/pages/News_feed.dart';
import 'package:ieeecrop/pages/Maati_Cam.dart';
import 'package:ieeecrop/pages/Main_menu.dart';
import 'package:ieeecrop/Functions_and_route.dart';

enum DrawerEvents { ProfileEvent, news, Createevent,menu,history,output,about}

abstract class DrawerStates {}

// Used for navigating between different blocs

class DrawerBloc extends Bloc<DrawerEvents, DrawerStates> {
  User user;
  DrawerBloc(this.user);
  @override
  DrawerStates get initialState => Main_menu();
  @override
  Stream<DrawerStates> mapEventToState(DrawerEvents event) async* {
    switch (event) {
      case DrawerEvents.menu:
        yield Main_menu();
        break;
      case DrawerEvents.ProfileEvent:
        yield UserScreen(user);
        break;
      case DrawerEvents.news:
        yield Maati_news();
        break;
      case DrawerEvents.output:
        yield output(null);
        break;
      case DrawerEvents.Createevent:
        yield maaticam();
        break;
      case DrawerEvents.history:
        yield history_screen();
        break;
      case DrawerEvents.about:
        yield about_us();
        break;
    }
  }
}
