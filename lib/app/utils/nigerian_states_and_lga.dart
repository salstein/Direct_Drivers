import '../../data/models/state_and_lga_model.dart';
import 'dummy_data.dart';

class GeneralHelper{
  List<StateAndLocalGovtModel> statesAndLga = stateAndLocalGovtModelFromJson(DummyData.statesAndLocalGovt);

  List<String> getStates(){
    return statesAndLga.map((e) => e.state.name).toList();
  }

  List<String> getStaLga(String stateName){
    var lgaList;
    statesAndLga.forEach((element) {
      if (element.state.name == stateName) {
        lgaList = element.state.locals.map((e) => e.name).toList();
      }
    });
    return lgaList;
  }

}