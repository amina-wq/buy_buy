part of 'address_bloc.dart';

sealed class AddressState extends Equatable {
  const AddressState();
}

final class AddressInitial extends AddressState {
  @override
  List<Object> get props => [];
}
