import 'package:auto_route/auto_route.dart';
import 'package:buy_buy/features/auth/auth.dart';
import 'package:buy_buy/features/profile/widgets/profile_card.dart';
import 'package:buy_buy/models/models.dart';
import 'package:buy_buy/ui/ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

@RoutePage()
class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  bool isEditing = false;

  late TextEditingController _nameController;
  late TextEditingController _phoneController;
  late Gender _gender;
  late DateTime _dateOfBirth;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController();
    _phoneController = TextEditingController();

    final authState = context.read<AuthBloc>().state;
    if (authState is Authorized) {
      _initializeFields(authState.profile);
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return BlocConsumer<AuthBloc, AuthState>(
      listener: _handleAuthState,
      builder: (context, state) {
        if (state is Authorized) {
          final dateOfBirthView = _dateOfBirth.toLocal().toString().split(' ')[0];

          return CustomScrollView(
            slivers: [
              SliverAppBar(
                snap: true,
                pinned: true,
                floating: true,
                centerTitle: true,
                elevation: 0,
                surfaceTintColor: Colors.transparent,
                title: const Text("Profile"),
                actions: [
                  if (isEditing)
                    IconButton(onPressed: _onSave, icon: Icon(Icons.save_outlined, color: theme.primaryColor))
                  else
                    IconButton(onPressed: _onToggleEdit, icon: Icon(Icons.edit_outlined, color: theme.primaryColor)),
                ],
              ),
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ProfileCard(
                        profile: state.profile,
                        nameBuilder: isEditing ? _nameBuilder : null,
                        genderBuilder: isEditing ? _genderBuilder : null,
                      ),
                      const SizedBox(height: 15),
                      BaseCard(
                        padding: const EdgeInsets.all(4),
                        child: ListTile(
                          title: Text(
                            "Phone",
                            style: theme.textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.w600, fontSize: 20),
                          ),
                          subtitle: TextFormField(
                            style: TextStyle(color: theme.primaryColor),
                            controller: _phoneController,
                            enabled: isEditing,
                            keyboardType: TextInputType.phone,
                            decoration: const InputDecoration(
                              border: InputBorder.none,
                              contentPadding: EdgeInsets.zero,
                              isDense: true,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 12),
                      BaseCard(
                        padding: const EdgeInsets.all(4),
                        child: ListTile(
                          title: Text(
                            "Date of Birth",
                            style: theme.textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.w600, fontSize: 20),
                          ),
                          subtitle: Text(dateOfBirthView, style: theme.textTheme.bodyLarge),
                          trailing: IconButton(
                            onPressed: isEditing ? _onDatePickerTap : null,
                            icon: Icon(
                              Icons.calendar_month_outlined,
                              color: isEditing ? theme.primaryColor : theme.colorScheme.primary,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                    ],
                  ),
                ),
              ),
            ],
          );
        } else if (state is ProfileUpdating) {
          return const Center(child: CircularProgressIndicator());
        }
        else {
          return const Center(child: Text("Please log in to view your profile."));
        }
      },
    );
  }

  void _handleAuthState(BuildContext context, AuthState state) {
    if (state is Authorized && isEditing) {
      setState(() => isEditing = false);
    }

    if (state is ProfileUpdateError) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Update failed: ${state.error}")));
    }
  }

  void _initializeFields(Profile profile) {
    _nameController.text = profile.name;
    _phoneController.text = profile.phone;
    _gender = profile.gender;
    _dateOfBirth = profile.dateOfBirth;
  }

  Widget _nameBuilder(BuildContext context) {
    final theme = Theme.of(context);
    return TextFormField(
      controller: _nameController,
      textAlign: TextAlign.center,
      style: theme.textTheme.titleLarge,
      decoration: const InputDecoration(border: InputBorder.none, isDense: true, contentPadding: EdgeInsets.zero),
    );
  }

  Widget _genderBuilder(BuildContext context) {
    return DropdownButton<Gender>(
      value: _gender,
      onChanged: (g) => setState(() => _gender = g!),
      icon: const Icon(Icons.arrow_drop_down),
      items:
          Gender.values
              .map(
                (g) => DropdownMenuItem(
                  value: g,
                  child: Row(children: [g.icon, const SizedBox(width: 8), Text(g.description)]),
                ),
              )
              .toList(),
    );
  }

  void _onToggleEdit() {
    setState(() {
      isEditing = !isEditing;
    });
  }

  void _onDatePickerTap() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: _dateOfBirth,
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (picked != null) setState(() => _dateOfBirth = picked);
  }

  void _onSave() {
    final authState = context.read<AuthBloc>().state;
    if (authState is! Authorized) return;

    final updatedProfile = authState.profile.copyWith(
      name: _nameController.text,
      phone: _phoneController.text,
      gender: _gender,
      dateOfBirth: _dateOfBirth,
    );

    context.read<AuthBloc>().add(ProfileUpdateEvent(updatedProfile: updatedProfile));
  }
}
