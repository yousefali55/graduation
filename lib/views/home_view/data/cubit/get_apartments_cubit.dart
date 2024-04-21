import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'get_apartments_state.dart';

class GetApartmentsCubit extends Cubit<GetApartmentsState> {
  GetApartmentsCubit() : super(GetApartmentsInitial());
}
