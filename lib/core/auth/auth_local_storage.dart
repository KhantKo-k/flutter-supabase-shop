import 'package:hive_ce/hive.dart';
import 'package:shop_project/features/auth/domain/email/entity/email_identity.dart';

abstract class AuthLocalStorage {
  Future<void> saveIdentity(EmailIdentity identity);
  EmailIdentity? getIdentity();
  Future<void> clearIdentity();
}

class AuthLocalStorageImpl implements AuthLocalStorage{
  static const _boxName = 'authBox';
  static const _identityKey = 'identity';

  @override
  Future<void> saveIdentity(EmailIdentity identity) async {
    final box = Hive.box(_boxName);
    await box.put(_identityKey, identity);
  }

  @override
  EmailIdentity? getIdentity(){
    final box = Hive.box(_boxName);
    return box.get(_identityKey);
  }

  @override
  Future<void> clearIdentity() async {
    final box = Hive.box(_boxName);
    await box.delete(_identityKey);
  }
}