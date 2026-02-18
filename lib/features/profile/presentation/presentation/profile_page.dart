import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_project/features/profile/domain/entities/profile_entity.dart';
import 'package:shop_project/features/profile/presentation/bloc/profile_bloc.dart';
import 'package:shop_project/features/profile/presentation/bloc/profile_event.dart';
import 'package:shop_project/features/profile/presentation/bloc/profile_state.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileBloc, ProfileState>(
      builder: (context, state) {
        if (state is ProfileLoading) {
          return const CircularProgressIndicator();
        }

        if (state is ProfileError) {
          return Center(child: Text(state.message));
        }

        if (state is ProflileLoaded){
          return Column(
            children: [
              _buildProfileDetail(state.profile,context),
            ],
          );
        }
        return const SizedBox();
      },
    );
  }
  Widget _buildProfileDetail(ProfileEntity profile, BuildContext context){
    return Card(
      margin: const EdgeInsets.all(16.0),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const CircleAvatar(radius: 40,
            child: Icon(Icons.person, size:  40,),),
            const SizedBox(height: 12,),
            Text(profile.username ?? 'No name'),
            Text(profile.email),
            const SizedBox(height: 12,),
            ElevatedButton.icon(onPressed: (){
              context.read<ProfileBloc>().add(
                UpdateProfle(profile)
              );
            },
            icon: const Icon(Icons.edit),
            label: const Text('Update Profile'))
          ],
        ),
      ),
    );
  }
}
