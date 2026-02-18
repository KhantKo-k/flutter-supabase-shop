import 'package:shop_project/features/profile/data/model/profile_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract class ProfileRemoteDatasource {
  Future<ProfileModel> getProfile();
  Future<void> updateProfile(ProfileModel profile);
}

class ProfileRemoteDatasourceImpl implements ProfileRemoteDatasource {
  final SupabaseClient client;

  ProfileRemoteDatasourceImpl(this.client);

  @override
  Future<ProfileModel> getProfile() async {
    final user = client.auth.currentUser;

    if (user == null) throw AuthException('Not Logged in');

    final data = await client
        .from('profiles')
        .select()
        .eq('id', user.id)
        .single();

    return ProfileModel.fromJson(data);
  }

  @override
  Future<void> updateProfile(ProfileModel profile) async {
    await client.from('profile').update(profile.toJson()).eq('id', profile.id);
  }
}
