import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'salesman_state.dart';

class SalesmanCubit extends Cubit<SalesmanState> {
  SalesmanCubit() : super(SalesmanInitial());
}
