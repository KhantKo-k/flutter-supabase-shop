
import 'package:shop_project/core/auth/auth_local_storage.dart';
import 'package:shop_project/features/auth/data/password/models/user_auth_model.dart';
import 'package:shop_project/features/auth/domain/password/entity/user_entity.dart';
import 'package:supabase_flutter/supabase_flutter.dart';


abstract class AuthRemoteDataSource {
  Future<UserEntity> login(String email, String password);
  Future<UserEntity> signUp(String username, String email, String password, String phone);
  Future<void> accountDeletion();
}

class AuthRemoteDataSourceImpl extends AuthRemoteDataSource {
  final SupabaseClient client;
  final AuthLocalStorage local;

  AuthRemoteDataSourceImpl(this.client,this.local);

  @override
  Future<UserEntity> login(
    String email,
    String password,
  ) async {
    
      final response = await client.auth.signInWithPassword(
        email: email,
        password: password,
      );

      final user = response.user;
      return UserAuthModel.fromSupabase(user!);
  }

  @override
  Future<UserEntity> signUp(
    String username,
    String email,
    String password,
    String phone,
  ) async {
    
      final response = await client.auth.signUp(
        email: email,
        password: password,
      );

      final user = response.user;

      await client.from('profiles').insert({
        'id': user!.id,
        'email': user.email,
        'username': username,
        'avatar_url': null,
        'phone': phone,
        'created_at': DateTime.now().toIso8601String(),
      });

      return UserAuthModel.fromSupabase(user);
    
  }

  @override
  Future<void> accountDeletion() async {
    final response = await client.functions.invoke('delete-user');
    local.clearIdentity();
    if(response.status != 200){
      throw Exception('Failed to delete account: ${response.data}');
    }
  }
}
