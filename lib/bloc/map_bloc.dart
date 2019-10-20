import 'package:coding_task/models.dart';
import 'package:coding_task/services/map_service.dart';
import 'package:rxdart/rxdart.dart';

class MapBloc 
{
  BehaviorSubject<Event> action = new BehaviorSubject<Event>();
  Stream<Response> response;

  MapBloc() {
    response = action.asyncMap((event) {
        if(event is CurrentLocationEvent)
          return  MapService.getCurrentLocation();
        else if(event is PlotRouteEvent){
          return MapService.getRoute(event);

        }
        else
          return ErrorResponse("NO event is specified");
    });
    action.add(CurrentLocationEvent());
  }
}