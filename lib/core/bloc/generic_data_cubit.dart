import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/common/bloc/generic_data_state.dart';
import 'package:movie_app/core/usecases/usecase.dart';

class GenericDataCubit extends Cubit<GenericDataState> {
  
  GenericDataCubit() : super(DataLoading());


  void getData<T>(Usecase usecase, {dynamic params}) async {
    var returnedData = await usecase.call(params: params);
    returnedData.fold(
      (error){
        emit(
          FailureLoadData(errorMessage: error)
        );
      },
      (data){
        emit(
          DataLoaded<T>(data: data)
        );
      }
    );
  }

 
}