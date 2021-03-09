import 'dart:async';

import 'package:YOURDRS_FlutterAPP/data/model/pin_generation_model.dart';
import 'package:YOURDRS_FlutterAPP/data/service/pin_generation_api.dart';
import 'package:bloc/bloc.dart';

part 'pin_screen_generate_event.dart';
part 'pin_screen_generate_state.dart';

class PinScreenGenerateBloc extends Bloc<PinGenerateScreenEvent, PinGenerateScreenState> {
  PinGenerateResponse pinGenerateResponse;                                      ///creating object of model class for pin generation
  PinScreenGenerateBloc(this.pinGenerateResponse) : super(PinGenerateScreenState());

  @override
  Stream<PinGenerateScreenState> mapEventToState(
      PinGenerateScreenEvent event,
      ) async* {
    // TODO: implement mapEventToState
    if(event is PinGenerateScreenEvent){
      print(event.memberId);
      PinGenerateModel pinGenerateModel = await pinGenerateResponse.postApiMethod(event.memberId,event.pin);    ///storing api response in model class
      print(pinGenerateModel);
      if(pinGenerateModel.header.statusCode=="200") {
        print('Validate Screen');
        yield PinGenerateScreenState(isTrue: true);     ///returning true value if status code is 200
      }
      else if (pinGenerateModel.header.statusCode== "406"){
        print('ShowSnackbar');
        yield PinGenerateScreenState(isTrue: false);
      }
    }
  }
}
