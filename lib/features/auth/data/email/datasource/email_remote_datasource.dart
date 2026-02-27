
import 'package:shop_project/features/auth/data/email/models/email_identity_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract class EmailRemoteDatasource {
  Future<EmailIdentityModel> checkEmail(String email);
}

class EmailRemoteDatasourceImpl implements EmailRemoteDatasource {
  final SupabaseClient client;

  EmailRemoteDatasourceImpl(this.client);

  @override
  Future<EmailIdentityModel> checkEmail(String email) async {

      final repsonse = await client
          .from('profiles')
          .select('email, username, avatar_url')
          .eq('email', email)
          .single();

      return EmailIdentityModel.fromJson(repsonse);
    
  }
}
