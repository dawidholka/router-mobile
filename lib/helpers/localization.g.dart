import 'package:get/get.dart';

class Localization extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {
    'en': {
      'auth.signInButton': 'Sign In',
      'auth.loginFormField': 'Login',
      'auth.passwordFormField': 'Password',
      'auth.nameFormField': 'Name',
      'auth.signInErrorTitle': 'Sign In Error',
      'auth.signInError': 'Login failed: email or password incorrect.',
      'auth.resetPasswordLabelButton': 'Forgot password?',
      'auth.signUpLabelButton': 'Create an Account',
      'auth.signUpErrorTitle': 'Sign Up Failed.',
      'auth.signUpError': 'There was a problem signing up.  Please try again later.',
      'auth.signInLabelButton': 'Have an Account? Sign In.',
      'auth.resetPasswordNoticeTitle': 'Password Reset Email Sent',
      'auth.resetPasswordNotice': 'Check your email and follow the instructions to reset your password.',
      'auth.resetPasswordFailed': 'Password Reset Email Failed',
      'auth.signInonResetPasswordLabelButton': 'Sign In',
      'auth.updateUser': 'Update Profile',
      'auth.updateUserSuccessNoticeTitle': 'User Updated',
      'auth.updateUserSuccessNotice': 'User information successfully updated.',
      'auth.updateUserEmailInUse': 'That email address already has an account.',
      'auth.updateUserFailNotice': 'Failed to update user',
      'auth.enterPassword': 'Enter your password',
      'auth.cancel': 'Cancel',
      'auth.submit': 'Submit',
      'auth.changePasswordLabelButton': 'Change Password',
      'auth.resetPasswordTitle': 'Reset Password',
      'auth.updateProfileTitle': 'Update Profile',
      'auth.wrongPasswordNoticeTitle': 'Login Failed',
      'auth.wrongPasswordNotice': 'The password does not match our records.',
      'auth.unknownError': 'Unknown Error',
      'settings.title': 'Settings',
      'settings.language': 'Language',
      'settings.theme': 'Theme',
      'settings.signOut': 'Sign Out',
      'settings.dark': 'Dark',
      'settings.light': 'Light',
      'settings.system': 'System',
      'settings.updateProfile': 'Update Profile',
      'home.title': 'Home',
      'home.nameLabel': 'Name',
      'home.uidLabel': 'UID',
      'home.emailLabel': 'Email',
      'home.adminUserLabel': 'Admin User',
      'app.title': 'Flutter Starter Project',
      'validator.email': 'Please enter a valid email address.',
      'validator.password': 'Password must be at least 6 characters.',
      'validator.name': 'Please enter a name.',
      'validator.number': 'Please enter a number.',
      'validator.notEmpty': 'This is a required field.',
      'validator.amount': 'Please enter a number i.e. 250 - no dollar symbol and no cents',
    },
    'pl': {
      'common.save': 'Zapisz',
      'common.errorOccurred': 'Wyst??pi?? b????d',
      'common.waypoint': 'Punkt trasy',
      'common.address': 'Adres',
      'common.intercom': 'Kod do domofonu',
      'common.phone': 'Numer telefonu',
      'common.note': 'Notatka',
      'common.quantity': 'Ilo???? paczek',
      'common.content': 'Zawarto????',
      'common.driverNote': 'Notatka kierowcy',
      'common.yes': 'Tak',
      'common.no': 'Nie',
      'auth.signInButton': 'Zaloguj si??',
      'auth.loginFormField': 'Login',
      'auth.passwordFormField': 'Has??o',
      'auth.nameFormField': 'Nom',
      'auth.signInErrorTitle': 'B????d uwierzytelniania',
      'auth.signInError': 'B????dny login lub has??o.',
      'auth.resetPasswordLabelButton': 'Mot de passe oubli???',
      'auth.signUpLabelButton': 'Cr??er un compte',
      'auth.signUpErrorTitle': '??chec de l\'inscription.',
      'auth.signUpError': 'Il y avait un probl??me de signer. Veuillez r??essayer plus tard.',
      'auth.signInLabelButton': 'Avoir un compte? S\'identifier.',
      'auth.resetPasswordNoticeTitle': 'R??initialiser le mot de passe e-mail envoy??',
      'auth.resetPasswordNotice': 'V??rifiez votre e-mail et suivez les instructions pour r??initialiser votre mot de passe.',
      'auth.resetPasswordFailed': 'R??initialiser le mot de passe Email ??chec',
      'auth.signInonResetPasswordLabelButton': 'S\'identifier',
      'auth.updateUser': 'Mettre ?? jour le profil',
      'auth.updateUserSuccessNoticeTitle': 'Mise ?? jour l\'utilisateur',
      'auth.updateUserSuccessNotice': 'Informations sur l\'utilisateur mis ?? jour avec succ??s.',
      'auth.updateUserEmailInUse': 'Cette adresse e-mail a d??j?? un compte.',
      'auth.updateUserFailNotice': 'Impossible de mettre ?? jour l\'utilisateur',
      'auth.enterPassword': 'Tapez votre mot de passe',
      'auth.cancel': 'Annuler',
      'auth.submit': 'Soumettre',
      'auth.changePasswordLabelButton': 'Changer le mot de passe',
      'auth.resetPasswordTitle': 'r??initialiser le mot de passe',
      'auth.updateProfileTitle': 'Mettre ?? jour le profil',
      'auth.wrongPasswordNoticeTitle': 'B????d uwierzytelniania',
      'auth.wrongPasswordNotice': 'Le mot de passe ne correspond pas ?? nos dossiers.',
      'auth.unknownError': 'Erreur inconnue',
      'settings.title': 'Ustawienia',
      'settings.language': 'J??zyk',
      'settings.theme': 'Motyw',
      'settings.signOut': 'Wyloguj si??',
      'settings.dark': 'Dark',
      'settings.light': 'Light',
      'settings.system': 'System',
      'settings.updateProfile': 'Mettre ?? jour le profil',
      'home.title': 'Strona g????wna',
      'home.nameLabel': 'U??ytkownik',
      'home.uidLabel': 'UID',
      'home.emailLabel': 'E-mail',
      'home.adminUserLabel': 'utilisateur admin',
      'app.title': 'Flutter projet de d??marrage',
      'routes.title': 'Trasy',
      'routes.routeDownloadedTitle': 'Pobrano tras??',
      'routes.routeDownloaded': 'Dane trasy zosta??y pobrane pomy??lnie.',
      'currentRoute.title': 'Aktualna trasa',
      'currentRoute.delivered': 'Dostarczone',
      'currentRoute.undelivered': 'Niedostarczone',
      'currentRoute.updateStatusErrorTitle': 'Nie mo??na zmieni?? statusu dostarczenia',
      'currentRoute.statusUpdatedTitle': 'Zmiana statusu',
      'currentRoute.statusUpdated': 'Zapisano zmiane statusu dostarczenia.',
      'about.title': 'O aplikacji',
      'map.title': 'Mapa',
      'waypoint.driverNote': 'Notatka kierowcy',
      'waypoint.noteEdit': 'Edycja notatki',
      'waypoint.photoUploaded': 'Wgrano zdj??cie',
      'waypoint.deliveryProblem': 'Problem z dostarczeniem',
      'waypoint.editDriverNote': 'Edytuj notatk?? kierowcy',
      'waypoint.navigate': 'Nawigacja',
      'waypoint.call': 'Zadzwo??',
      'waypoint.sendSMS': 'Wy??lij SMS',
      'waypoint.takePhoto': 'Zr??b zdj??cie',
      'validator.email': 'S\'il vous pla??t, mettez une adresse email valide.',
      'validator.password': 'Has??o musi zawiera?? conajmniej 6 znak??w.',
      'validator.login': 'Wprowad?? prawid??owy login.',
      'validator.name': 'S\'il vous pla??t entrer un nom.',
      'validator.number': 'S\'il vous pla??t entrer un num??ro.',
      'validator.notEmpty': 'Ceci est un champ obligatoire.',
      'validator.amount': 'S\'il vous pla??t entrer un num??ro ?? savoir 250 - aucun symbole du dollar et pas cents',
    }
  };
}
