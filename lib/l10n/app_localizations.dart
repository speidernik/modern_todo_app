import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_de.dart';
import 'app_localizations_en.dart';
import 'app_localizations_es.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
      : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('de'),
    Locale('en'),
    Locale('es')
  ];

  /// No description provided for @appName.
  ///
  /// In en, this message translates to:
  /// **'X in one'**
  String get appName;

  /// No description provided for @settings.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settings;

  /// No description provided for @themeMode.
  ///
  /// In en, this message translates to:
  /// **'Theme Mode'**
  String get themeMode;

  /// No description provided for @language.
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get language;

  /// No description provided for @accountSettings.
  ///
  /// In en, this message translates to:
  /// **'Account Settings'**
  String get accountSettings;

  /// No description provided for @updateUsername.
  ///
  /// In en, this message translates to:
  /// **'Update Username'**
  String get updateUsername;

  /// No description provided for @updateEmail.
  ///
  /// In en, this message translates to:
  /// **'Update Email'**
  String get updateEmail;

  /// No description provided for @updatePassword.
  ///
  /// In en, this message translates to:
  /// **'Update Password'**
  String get updatePassword;

  /// No description provided for @currentPassword.
  ///
  /// In en, this message translates to:
  /// **'Current Password'**
  String get currentPassword;

  /// No description provided for @newPassword.
  ///
  /// In en, this message translates to:
  /// **'New Password'**
  String get newPassword;

  /// No description provided for @confirmPassword.
  ///
  /// In en, this message translates to:
  /// **'Confirm Password'**
  String get confirmPassword;

  /// No description provided for @username.
  ///
  /// In en, this message translates to:
  /// **'Username'**
  String get username;

  /// No description provided for @email.
  ///
  /// In en, this message translates to:
  /// **'Email'**
  String get email;

  /// No description provided for @system.
  ///
  /// In en, this message translates to:
  /// **'System'**
  String get system;

  /// No description provided for @light.
  ///
  /// In en, this message translates to:
  /// **'Light'**
  String get light;

  /// No description provided for @dark.
  ///
  /// In en, this message translates to:
  /// **'Dark'**
  String get dark;

  /// No description provided for @english.
  ///
  /// In en, this message translates to:
  /// **'English'**
  String get english;

  /// No description provided for @german.
  ///
  /// In en, this message translates to:
  /// **'German'**
  String get german;

  /// No description provided for @spanish.
  ///
  /// In en, this message translates to:
  /// **'Spanish'**
  String get spanish;

  /// No description provided for @editAccountSettings.
  ///
  /// In en, this message translates to:
  /// **'Edit Account Settings'**
  String get editAccountSettings;

  /// No description provided for @settingsUpdated.
  ///
  /// In en, this message translates to:
  /// **'Settings updated successfully'**
  String get settingsUpdated;

  /// No description provided for @errorUpdatingSettings.
  ///
  /// In en, this message translates to:
  /// **'Error updating settings: {error}'**
  String errorUpdatingSettings(String error);

  /// No description provided for @appSettings.
  ///
  /// In en, this message translates to:
  /// **'App Settings'**
  String get appSettings;

  /// No description provided for @userSettings.
  ///
  /// In en, this message translates to:
  /// **'User Settings'**
  String get userSettings;

  /// No description provided for @changeUsername.
  ///
  /// In en, this message translates to:
  /// **'Change Username'**
  String get changeUsername;

  /// No description provided for @changePassword.
  ///
  /// In en, this message translates to:
  /// **'Change Password'**
  String get changePassword;

  /// No description provided for @changeEmail.
  ///
  /// In en, this message translates to:
  /// **'Change Email'**
  String get changeEmail;

  /// No description provided for @confirmNewPassword.
  ///
  /// In en, this message translates to:
  /// **'Confirm New Password'**
  String get confirmNewPassword;

  /// No description provided for @usernameChanged.
  ///
  /// In en, this message translates to:
  /// **'Username changed successfully'**
  String get usernameChanged;

  /// No description provided for @passwordChanged.
  ///
  /// In en, this message translates to:
  /// **'Password changed successfully'**
  String get passwordChanged;

  /// No description provided for @emailChanged.
  ///
  /// In en, this message translates to:
  /// **'Email changed successfully'**
  String get emailChanged;

  /// No description provided for @usernameCannotBeEmpty.
  ///
  /// In en, this message translates to:
  /// **'Username cannot be empty'**
  String get usernameCannotBeEmpty;

  /// No description provided for @failedToChangeUsername.
  ///
  /// In en, this message translates to:
  /// **'Failed to change username'**
  String get failedToChangeUsername;

  /// No description provided for @failedToChangePassword.
  ///
  /// In en, this message translates to:
  /// **'Failed to change password'**
  String get failedToChangePassword;

  /// No description provided for @failedToChangeEmail.
  ///
  /// In en, this message translates to:
  /// **'Failed to change email'**
  String get failedToChangeEmail;

  /// No description provided for @noUserSignedIn.
  ///
  /// In en, this message translates to:
  /// **'No user signed in'**
  String get noUserSignedIn;

  /// No description provided for @about.
  ///
  /// In en, this message translates to:
  /// **'About'**
  String get about;

  /// No description provided for @version.
  ///
  /// In en, this message translates to:
  /// **'Version'**
  String get version;

  /// The source code link text
  ///
  /// In en, this message translates to:
  /// **'Source Code'**
  String get sourceCode;

  /// No description provided for @tasks.
  ///
  /// In en, this message translates to:
  /// **'Tasks'**
  String get tasks;

  /// No description provided for @addTask.
  ///
  /// In en, this message translates to:
  /// **'Add Task'**
  String get addTask;

  /// No description provided for @taskTitle.
  ///
  /// In en, this message translates to:
  /// **'Task Title'**
  String get taskTitle;

  /// No description provided for @title.
  ///
  /// In en, this message translates to:
  /// **'Title'**
  String get title;

  /// No description provided for @titleRequired.
  ///
  /// In en, this message translates to:
  /// **'Title is required'**
  String get titleRequired;

  /// No description provided for @description.
  ///
  /// In en, this message translates to:
  /// **'Description'**
  String get description;

  /// No description provided for @descriptionOptional.
  ///
  /// In en, this message translates to:
  /// **'Description (optional)'**
  String get descriptionOptional;

  /// No description provided for @category.
  ///
  /// In en, this message translates to:
  /// **'Category'**
  String get category;

  /// No description provided for @dueDate.
  ///
  /// In en, this message translates to:
  /// **'Due Date'**
  String get dueDate;

  /// No description provided for @setDueDate.
  ///
  /// In en, this message translates to:
  /// **'Set Due Date'**
  String get setDueDate;

  /// No description provided for @searchTasks.
  ///
  /// In en, this message translates to:
  /// **'Search tasks...'**
  String get searchTasks;

  /// No description provided for @hideCompleted.
  ///
  /// In en, this message translates to:
  /// **'Hide Completed'**
  String get hideCompleted;

  /// No description provided for @showCompleted.
  ///
  /// In en, this message translates to:
  /// **'Show Completed'**
  String get showCompleted;

  /// No description provided for @showUncompleted.
  ///
  /// In en, this message translates to:
  /// **'Show Uncompleted'**
  String get showUncompleted;

  /// No description provided for @all.
  ///
  /// In en, this message translates to:
  /// **'All'**
  String get all;

  /// No description provided for @noTasks.
  ///
  /// In en, this message translates to:
  /// **'No tasks yet'**
  String get noTasks;

  /// No description provided for @delete.
  ///
  /// In en, this message translates to:
  /// **'Delete'**
  String get delete;

  /// No description provided for @enterTitle.
  ///
  /// In en, this message translates to:
  /// **'Enter title'**
  String get enterTitle;

  /// No description provided for @deleteTask.
  ///
  /// In en, this message translates to:
  /// **'Delete Task'**
  String get deleteTask;

  /// No description provided for @deleteTaskConfirmation.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to delete this task?'**
  String get deleteTaskConfirmation;

  /// No description provided for @taskDeleted.
  ///
  /// In en, this message translates to:
  /// **'Task deleted'**
  String get taskDeleted;

  /// No description provided for @myTasks.
  ///
  /// In en, this message translates to:
  /// **'My Tasks'**
  String get myTasks;

  /// No description provided for @edit.
  ///
  /// In en, this message translates to:
  /// **'Edit'**
  String get edit;

  /// No description provided for @personal.
  ///
  /// In en, this message translates to:
  /// **'Personal'**
  String get personal;

  /// No description provided for @work.
  ///
  /// In en, this message translates to:
  /// **'Work'**
  String get work;

  /// No description provided for @shopping.
  ///
  /// In en, this message translates to:
  /// **'Shopping'**
  String get shopping;

  /// No description provided for @health.
  ///
  /// In en, this message translates to:
  /// **'Health'**
  String get health;

  /// No description provided for @education.
  ///
  /// In en, this message translates to:
  /// **'Education'**
  String get education;

  /// No description provided for @finance.
  ///
  /// In en, this message translates to:
  /// **'Finance'**
  String get finance;

  /// No description provided for @markDone.
  ///
  /// In en, this message translates to:
  /// **'Mark as Done'**
  String get markDone;

  /// No description provided for @markUndone.
  ///
  /// In en, this message translates to:
  /// **'Mark as Undone'**
  String get markUndone;

  /// No description provided for @manageCategories.
  ///
  /// In en, this message translates to:
  /// **'Manage Categories'**
  String get manageCategories;

  /// No description provided for @addCategory.
  ///
  /// In en, this message translates to:
  /// **'Add Category'**
  String get addCategory;

  /// No description provided for @categoryName.
  ///
  /// In en, this message translates to:
  /// **'Category Name'**
  String get categoryName;

  /// No description provided for @enterCategoryName.
  ///
  /// In en, this message translates to:
  /// **'Enter category name'**
  String get enterCategoryName;

  /// No description provided for @deleteCategory.
  ///
  /// In en, this message translates to:
  /// **'Delete Category'**
  String get deleteCategory;

  /// No description provided for @deleteCategoryConfirmation.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to delete this category?'**
  String get deleteCategoryConfirmation;

  /// No description provided for @add.
  ///
  /// In en, this message translates to:
  /// **'Add'**
  String get add;

  /// No description provided for @favorites.
  ///
  /// In en, this message translates to:
  /// **'Favorites'**
  String get favorites;

  /// No description provided for @screenshots.
  ///
  /// In en, this message translates to:
  /// **'Screenshots'**
  String get screenshots;

  /// No description provided for @camera.
  ///
  /// In en, this message translates to:
  /// **'Camera'**
  String get camera;

  /// No description provided for @addToFavorites.
  ///
  /// In en, this message translates to:
  /// **'Add to Favorites'**
  String get addToFavorites;

  /// No description provided for @removeFromFavorites.
  ///
  /// In en, this message translates to:
  /// **'Remove from Favorites'**
  String get removeFromFavorites;

  /// No description provided for @hide.
  ///
  /// In en, this message translates to:
  /// **'Hide'**
  String get hide;

  /// No description provided for @unhide.
  ///
  /// In en, this message translates to:
  /// **'Unhide'**
  String get unhide;

  /// No description provided for @selectCategory.
  ///
  /// In en, this message translates to:
  /// **'Select Category'**
  String get selectCategory;

  /// No description provided for @editTask.
  ///
  /// In en, this message translates to:
  /// **'Edit Task'**
  String get editTask;

  /// No description provided for @save.
  ///
  /// In en, this message translates to:
  /// **'Save'**
  String get save;

  /// No description provided for @errorSaving.
  ///
  /// In en, this message translates to:
  /// **'Error saving task'**
  String get errorSaving;

  /// No description provided for @taskUpdated.
  ///
  /// In en, this message translates to:
  /// **'Task updated successfully'**
  String get taskUpdated;

  /// No description provided for @taskAdded.
  ///
  /// In en, this message translates to:
  /// **'Task added successfully'**
  String get taskAdded;

  /// No description provided for @totalTasks.
  ///
  /// In en, this message translates to:
  /// **'Total Tasks'**
  String get totalTasks;

  /// No description provided for @active.
  ///
  /// In en, this message translates to:
  /// **'Active'**
  String get active;

  /// No description provided for @completionRate.
  ///
  /// In en, this message translates to:
  /// **'Completion Rate'**
  String get completionRate;

  /// No description provided for @filter.
  ///
  /// In en, this message translates to:
  /// **'Filter'**
  String get filter;

  /// No description provided for @sortBy.
  ///
  /// In en, this message translates to:
  /// **'Sort By'**
  String get sortBy;

  /// No description provided for @priority.
  ///
  /// In en, this message translates to:
  /// **'Priority'**
  String get priority;

  /// No description provided for @low.
  ///
  /// In en, this message translates to:
  /// **'Low'**
  String get low;

  /// No description provided for @medium.
  ///
  /// In en, this message translates to:
  /// **'Medium'**
  String get medium;

  /// No description provided for @high.
  ///
  /// In en, this message translates to:
  /// **'High'**
  String get high;

  /// No description provided for @completed.
  ///
  /// In en, this message translates to:
  /// **'Completed'**
  String get completed;

  /// No description provided for @error.
  ///
  /// In en, this message translates to:
  /// **'Error'**
  String get error;

  /// No description provided for @cancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancel;

  /// No description provided for @undo.
  ///
  /// In en, this message translates to:
  /// **'Undo'**
  String get undo;

  /// No description provided for @loading.
  ///
  /// In en, this message translates to:
  /// **'Loading...'**
  String get loading;

  /// No description provided for @comingSoon.
  ///
  /// In en, this message translates to:
  /// **'Coming Soon'**
  String get comingSoon;

  /// No description provided for @uncategorized.
  ///
  /// In en, this message translates to:
  /// **'Uncategorized'**
  String get uncategorized;

  /// No description provided for @retry.
  ///
  /// In en, this message translates to:
  /// **'Retry'**
  String get retry;

  /// No description provided for @statistics.
  ///
  /// In en, this message translates to:
  /// **'Statistics'**
  String get statistics;

  /// No description provided for @calendar.
  ///
  /// In en, this message translates to:
  /// **'Calendar'**
  String get calendar;

  /// No description provided for @gallery.
  ///
  /// In en, this message translates to:
  /// **'Gallery'**
  String get gallery;

  /// No description provided for @enterTaskTitle.
  ///
  /// In en, this message translates to:
  /// **'Enter task title...'**
  String get enterTaskTitle;

  /// No description provided for @addDescriptionOptional.
  ///
  /// In en, this message translates to:
  /// **'Add description (optional)...'**
  String get addDescriptionOptional;

  /// No description provided for @selectDueDate.
  ///
  /// In en, this message translates to:
  /// **'Select due date'**
  String get selectDueDate;

  /// No description provided for @selectTimeOptional.
  ///
  /// In en, this message translates to:
  /// **'Select time (optional)'**
  String get selectTimeOptional;

  /// No description provided for @welcomeBack.
  ///
  /// In en, this message translates to:
  /// **'Welcome Back'**
  String get welcomeBack;

  /// No description provided for @createAccount.
  ///
  /// In en, this message translates to:
  /// **'Create Account'**
  String get createAccount;

  /// No description provided for @loginSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Sign in to continue'**
  String get loginSubtitle;

  /// No description provided for @signupSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Create an account to get started'**
  String get signupSubtitle;

  /// No description provided for @password.
  ///
  /// In en, this message translates to:
  /// **'Password'**
  String get password;

  /// No description provided for @login.
  ///
  /// In en, this message translates to:
  /// **'Login'**
  String get login;

  /// No description provided for @signup.
  ///
  /// In en, this message translates to:
  /// **'Sign Up'**
  String get signup;

  /// No description provided for @forgotPassword.
  ///
  /// In en, this message translates to:
  /// **'Forgot Password?'**
  String get forgotPassword;

  /// No description provided for @dontHaveAccount.
  ///
  /// In en, this message translates to:
  /// **'Don\'t have an account?'**
  String get dontHaveAccount;

  /// No description provided for @alreadyHaveAccount.
  ///
  /// In en, this message translates to:
  /// **'Already have an account?'**
  String get alreadyHaveAccount;

  /// No description provided for @signInWithGoogle.
  ///
  /// In en, this message translates to:
  /// **'Sign in with Google'**
  String get signInWithGoogle;

  /// No description provided for @signUpWithGoogle.
  ///
  /// In en, this message translates to:
  /// **'Sign up with Google'**
  String get signUpWithGoogle;

  /// No description provided for @or.
  ///
  /// In en, this message translates to:
  /// **'or'**
  String get or;

  /// No description provided for @emailRequired.
  ///
  /// In en, this message translates to:
  /// **'Email is required'**
  String get emailRequired;

  /// No description provided for @invalidEmail.
  ///
  /// In en, this message translates to:
  /// **'Please enter a valid email'**
  String get invalidEmail;

  /// No description provided for @passwordRequired.
  ///
  /// In en, this message translates to:
  /// **'Password is required'**
  String get passwordRequired;

  /// No description provided for @passwordTooShort.
  ///
  /// In en, this message translates to:
  /// **'Password must be at least 6 characters'**
  String get passwordTooShort;

  /// No description provided for @confirmPasswordRequired.
  ///
  /// In en, this message translates to:
  /// **'Please confirm your password'**
  String get confirmPasswordRequired;

  /// No description provided for @passwordsDoNotMatch.
  ///
  /// In en, this message translates to:
  /// **'Passwords do not match'**
  String get passwordsDoNotMatch;

  /// No description provided for @loginFailed.
  ///
  /// In en, this message translates to:
  /// **'Login failed'**
  String get loginFailed;

  /// No description provided for @signupFailed.
  ///
  /// In en, this message translates to:
  /// **'Sign up failed'**
  String get signupFailed;

  /// No description provided for @logout.
  ///
  /// In en, this message translates to:
  /// **'Logout'**
  String get logout;

  /// No description provided for @logoutConfirmation.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to logout?'**
  String get logoutConfirmation;

  /// No description provided for @logoutFailed.
  ///
  /// In en, this message translates to:
  /// **'Logout failed'**
  String get logoutFailed;

  /// No description provided for @profile.
  ///
  /// In en, this message translates to:
  /// **'Profile'**
  String get profile;

  /// No description provided for @editProfile.
  ///
  /// In en, this message translates to:
  /// **'Edit Profile'**
  String get editProfile;

  /// No description provided for @changePhoto.
  ///
  /// In en, this message translates to:
  /// **'Change Photo'**
  String get changePhoto;

  /// No description provided for @takePhoto.
  ///
  /// In en, this message translates to:
  /// **'Take Photo'**
  String get takePhoto;

  /// No description provided for @chooseFromGallery.
  ///
  /// In en, this message translates to:
  /// **'Choose from Gallery'**
  String get chooseFromGallery;

  /// No description provided for @removePhoto.
  ///
  /// In en, this message translates to:
  /// **'Remove Photo'**
  String get removePhoto;

  /// No description provided for @photoUpdated.
  ///
  /// In en, this message translates to:
  /// **'Photo updated successfully'**
  String get photoUpdated;

  /// No description provided for @photoUpdateFailed.
  ///
  /// In en, this message translates to:
  /// **'Failed to update photo'**
  String get photoUpdateFailed;

  /// No description provided for @notifications.
  ///
  /// In en, this message translates to:
  /// **'Notifications'**
  String get notifications;

  /// No description provided for @notificationSettings.
  ///
  /// In en, this message translates to:
  /// **'Notification Settings'**
  String get notificationSettings;

  /// No description provided for @pushNotifications.
  ///
  /// In en, this message translates to:
  /// **'Push Notifications'**
  String get pushNotifications;

  /// No description provided for @emailNotifications.
  ///
  /// In en, this message translates to:
  /// **'Email Notifications'**
  String get emailNotifications;

  /// No description provided for @soundEnabled.
  ///
  /// In en, this message translates to:
  /// **'Sound Enabled'**
  String get soundEnabled;

  /// No description provided for @vibrationEnabled.
  ///
  /// In en, this message translates to:
  /// **'Vibration Enabled'**
  String get vibrationEnabled;

  /// No description provided for @notificationSettingsUpdated.
  ///
  /// In en, this message translates to:
  /// **'Notification settings updated'**
  String get notificationSettingsUpdated;

  /// No description provided for @help.
  ///
  /// In en, this message translates to:
  /// **'Help'**
  String get help;

  /// No description provided for @support.
  ///
  /// In en, this message translates to:
  /// **'Support'**
  String get support;

  /// No description provided for @contactUs.
  ///
  /// In en, this message translates to:
  /// **'Contact Us'**
  String get contactUs;

  /// No description provided for @faq.
  ///
  /// In en, this message translates to:
  /// **'FAQ'**
  String get faq;

  /// No description provided for @privacyPolicy.
  ///
  /// In en, this message translates to:
  /// **'Privacy Policy'**
  String get privacyPolicy;

  /// No description provided for @termsOfService.
  ///
  /// In en, this message translates to:
  /// **'Terms of Service'**
  String get termsOfService;

  /// No description provided for @feedback.
  ///
  /// In en, this message translates to:
  /// **'Feedback'**
  String get feedback;

  /// No description provided for @rateApp.
  ///
  /// In en, this message translates to:
  /// **'Rate App'**
  String get rateApp;

  /// No description provided for @shareApp.
  ///
  /// In en, this message translates to:
  /// **'Share App'**
  String get shareApp;

  /// No description provided for @reportBug.
  ///
  /// In en, this message translates to:
  /// **'Report Bug'**
  String get reportBug;

  /// No description provided for @suggestFeature.
  ///
  /// In en, this message translates to:
  /// **'Suggest Feature'**
  String get suggestFeature;

  /// No description provided for @thankYou.
  ///
  /// In en, this message translates to:
  /// **'Thank You'**
  String get thankYou;

  /// No description provided for @feedbackSubmitted.
  ///
  /// In en, this message translates to:
  /// **'Feedback submitted successfully'**
  String get feedbackSubmitted;

  /// No description provided for @feedbackFailed.
  ///
  /// In en, this message translates to:
  /// **'Failed to submit feedback'**
  String get feedbackFailed;

  /// No description provided for @search.
  ///
  /// In en, this message translates to:
  /// **'Search'**
  String get search;

  /// No description provided for @clear.
  ///
  /// In en, this message translates to:
  /// **'Clear'**
  String get clear;

  /// No description provided for @apply.
  ///
  /// In en, this message translates to:
  /// **'Apply'**
  String get apply;

  /// No description provided for @reset.
  ///
  /// In en, this message translates to:
  /// **'Reset'**
  String get reset;

  /// No description provided for @sort.
  ///
  /// In en, this message translates to:
  /// **'Sort'**
  String get sort;

  /// No description provided for @group.
  ///
  /// In en, this message translates to:
  /// **'Group'**
  String get group;

  /// No description provided for @view.
  ///
  /// In en, this message translates to:
  /// **'View'**
  String get view;

  /// No description provided for @list.
  ///
  /// In en, this message translates to:
  /// **'List'**
  String get list;

  /// No description provided for @grid.
  ///
  /// In en, this message translates to:
  /// **'Grid'**
  String get grid;

  /// No description provided for @compact.
  ///
  /// In en, this message translates to:
  /// **'Compact'**
  String get compact;

  /// No description provided for @comfortable.
  ///
  /// In en, this message translates to:
  /// **'Comfortable'**
  String get comfortable;

  /// No description provided for @today.
  ///
  /// In en, this message translates to:
  /// **'Today'**
  String get today;

  /// No description provided for @tomorrow.
  ///
  /// In en, this message translates to:
  /// **'Tomorrow'**
  String get tomorrow;

  /// No description provided for @yesterday.
  ///
  /// In en, this message translates to:
  /// **'Yesterday'**
  String get yesterday;

  /// No description provided for @thisWeek.
  ///
  /// In en, this message translates to:
  /// **'This Week'**
  String get thisWeek;

  /// No description provided for @nextWeek.
  ///
  /// In en, this message translates to:
  /// **'Next Week'**
  String get nextWeek;

  /// No description provided for @thisMonth.
  ///
  /// In en, this message translates to:
  /// **'This Month'**
  String get thisMonth;

  /// No description provided for @nextMonth.
  ///
  /// In en, this message translates to:
  /// **'Next Month'**
  String get nextMonth;

  /// No description provided for @overdue.
  ///
  /// In en, this message translates to:
  /// **'Overdue'**
  String get overdue;

  /// No description provided for @dueSoon.
  ///
  /// In en, this message translates to:
  /// **'Due Soon'**
  String get dueSoon;

  /// No description provided for @noDueDate.
  ///
  /// In en, this message translates to:
  /// **'No Due Date'**
  String get noDueDate;

  /// No description provided for @quickAdd.
  ///
  /// In en, this message translates to:
  /// **'Quick Add'**
  String get quickAdd;

  /// No description provided for @quickAddHint.
  ///
  /// In en, this message translates to:
  /// **'Type and press Enter to add a task'**
  String get quickAddHint;

  /// No description provided for @bulkActions.
  ///
  /// In en, this message translates to:
  /// **'Bulk Actions'**
  String get bulkActions;

  /// No description provided for @selectAll.
  ///
  /// In en, this message translates to:
  /// **'Select All'**
  String get selectAll;

  /// No description provided for @deselectAll.
  ///
  /// In en, this message translates to:
  /// **'Deselect All'**
  String get deselectAll;

  /// No description provided for @markSelectedDone.
  ///
  /// In en, this message translates to:
  /// **'Mark Selected as Done'**
  String get markSelectedDone;

  /// No description provided for @deleteSelected.
  ///
  /// In en, this message translates to:
  /// **'Delete Selected'**
  String get deleteSelected;

  /// No description provided for @moveSelected.
  ///
  /// In en, this message translates to:
  /// **'Move Selected'**
  String get moveSelected;

  /// No description provided for @copySelected.
  ///
  /// In en, this message translates to:
  /// **'Copy Selected'**
  String get copySelected;

  /// No description provided for @exportSelected.
  ///
  /// In en, this message translates to:
  /// **'Export Selected'**
  String get exportSelected;

  /// No description provided for @importTasks.
  ///
  /// In en, this message translates to:
  /// **'Import Tasks'**
  String get importTasks;

  /// No description provided for @exportTasks.
  ///
  /// In en, this message translates to:
  /// **'Export Tasks'**
  String get exportTasks;

  /// No description provided for @backupTasks.
  ///
  /// In en, this message translates to:
  /// **'Backup Tasks'**
  String get backupTasks;

  /// No description provided for @restoreTasks.
  ///
  /// In en, this message translates to:
  /// **'Restore Tasks'**
  String get restoreTasks;

  /// No description provided for @syncTasks.
  ///
  /// In en, this message translates to:
  /// **'Sync Tasks'**
  String get syncTasks;

  /// No description provided for @syncEnabled.
  ///
  /// In en, this message translates to:
  /// **'Sync Enabled'**
  String get syncEnabled;

  /// No description provided for @lastSync.
  ///
  /// In en, this message translates to:
  /// **'Last Sync'**
  String get lastSync;

  /// No description provided for @syncNow.
  ///
  /// In en, this message translates to:
  /// **'Sync Now'**
  String get syncNow;

  /// No description provided for @syncFailed.
  ///
  /// In en, this message translates to:
  /// **'Sync Failed'**
  String get syncFailed;

  /// No description provided for @syncSuccessful.
  ///
  /// In en, this message translates to:
  /// **'Sync Successful'**
  String get syncSuccessful;

  /// No description provided for @offline.
  ///
  /// In en, this message translates to:
  /// **'Offline'**
  String get offline;

  /// No description provided for @online.
  ///
  /// In en, this message translates to:
  /// **'Online'**
  String get online;

  /// No description provided for @connecting.
  ///
  /// In en, this message translates to:
  /// **'Connecting...'**
  String get connecting;

  /// No description provided for @connectionFailed.
  ///
  /// In en, this message translates to:
  /// **'Connection Failed'**
  String get connectionFailed;

  /// No description provided for @checkConnection.
  ///
  /// In en, this message translates to:
  /// **'Check Connection'**
  String get checkConnection;

  /// No description provided for @refresh.
  ///
  /// In en, this message translates to:
  /// **'Refresh'**
  String get refresh;

  /// No description provided for @pullToRefresh.
  ///
  /// In en, this message translates to:
  /// **'Pull to refresh'**
  String get pullToRefresh;

  /// No description provided for @releaseToRefresh.
  ///
  /// In en, this message translates to:
  /// **'Release to refresh'**
  String get releaseToRefresh;

  /// No description provided for @refreshing.
  ///
  /// In en, this message translates to:
  /// **'Refreshing...'**
  String get refreshing;

  /// No description provided for @noInternet.
  ///
  /// In en, this message translates to:
  /// **'No Internet Connection'**
  String get noInternet;

  /// No description provided for @checkInternet.
  ///
  /// In en, this message translates to:
  /// **'Please check your internet connection'**
  String get checkInternet;

  /// No description provided for @tryAgain.
  ///
  /// In en, this message translates to:
  /// **'Try Again'**
  String get tryAgain;

  /// No description provided for @close.
  ///
  /// In en, this message translates to:
  /// **'Close'**
  String get close;

  /// No description provided for @done.
  ///
  /// In en, this message translates to:
  /// **'Done'**
  String get done;

  /// No description provided for @next.
  ///
  /// In en, this message translates to:
  /// **'Next'**
  String get next;

  /// No description provided for @previous.
  ///
  /// In en, this message translates to:
  /// **'Previous'**
  String get previous;

  /// No description provided for @skip.
  ///
  /// In en, this message translates to:
  /// **'Skip'**
  String get skip;

  /// No description provided for @finish.
  ///
  /// In en, this message translates to:
  /// **'Finish'**
  String get finish;

  /// No description provided for @continueAction.
  ///
  /// In en, this message translates to:
  /// **'Continue'**
  String get continueAction;

  /// No description provided for @back.
  ///
  /// In en, this message translates to:
  /// **'Back'**
  String get back;

  /// No description provided for @forward.
  ///
  /// In en, this message translates to:
  /// **'Forward'**
  String get forward;

  /// No description provided for @home.
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get home;

  /// No description provided for @menu.
  ///
  /// In en, this message translates to:
  /// **'Menu'**
  String get menu;

  /// No description provided for @more.
  ///
  /// In en, this message translates to:
  /// **'More'**
  String get more;

  /// No description provided for @less.
  ///
  /// In en, this message translates to:
  /// **'Less'**
  String get less;

  /// No description provided for @expand.
  ///
  /// In en, this message translates to:
  /// **'Expand'**
  String get expand;

  /// No description provided for @collapse.
  ///
  /// In en, this message translates to:
  /// **'Collapse'**
  String get collapse;

  /// No description provided for @showMore.
  ///
  /// In en, this message translates to:
  /// **'Show More'**
  String get showMore;

  /// No description provided for @showLess.
  ///
  /// In en, this message translates to:
  /// **'Show Less'**
  String get showLess;

  /// No description provided for @details.
  ///
  /// In en, this message translates to:
  /// **'Details'**
  String get details;

  /// No description provided for @summary.
  ///
  /// In en, this message translates to:
  /// **'Summary'**
  String get summary;

  /// No description provided for @preview.
  ///
  /// In en, this message translates to:
  /// **'Preview'**
  String get preview;

  /// No description provided for @fullscreen.
  ///
  /// In en, this message translates to:
  /// **'Fullscreen'**
  String get fullscreen;

  /// No description provided for @exitFullscreen.
  ///
  /// In en, this message translates to:
  /// **'Exit Fullscreen'**
  String get exitFullscreen;

  /// No description provided for @zoomIn.
  ///
  /// In en, this message translates to:
  /// **'Zoom In'**
  String get zoomIn;

  /// No description provided for @zoomOut.
  ///
  /// In en, this message translates to:
  /// **'Zoom Out'**
  String get zoomOut;

  /// No description provided for @fitToScreen.
  ///
  /// In en, this message translates to:
  /// **'Fit to Screen'**
  String get fitToScreen;

  /// No description provided for @actualSize.
  ///
  /// In en, this message translates to:
  /// **'Actual Size'**
  String get actualSize;

  /// No description provided for @rotate.
  ///
  /// In en, this message translates to:
  /// **'Rotate'**
  String get rotate;

  /// No description provided for @flip.
  ///
  /// In en, this message translates to:
  /// **'Flip'**
  String get flip;

  /// No description provided for @crop.
  ///
  /// In en, this message translates to:
  /// **'Crop'**
  String get crop;

  /// No description provided for @brightness.
  ///
  /// In en, this message translates to:
  /// **'Brightness'**
  String get brightness;

  /// No description provided for @contrast.
  ///
  /// In en, this message translates to:
  /// **'Contrast'**
  String get contrast;

  /// No description provided for @saturation.
  ///
  /// In en, this message translates to:
  /// **'Saturation'**
  String get saturation;

  /// No description provided for @blur.
  ///
  /// In en, this message translates to:
  /// **'Blur'**
  String get blur;

  /// No description provided for @sharpen.
  ///
  /// In en, this message translates to:
  /// **'Sharpen'**
  String get sharpen;

  /// No description provided for @effects.
  ///
  /// In en, this message translates to:
  /// **'Effects'**
  String get effects;

  /// No description provided for @adjustments.
  ///
  /// In en, this message translates to:
  /// **'Adjustments'**
  String get adjustments;

  /// No description provided for @enhance.
  ///
  /// In en, this message translates to:
  /// **'Enhance'**
  String get enhance;

  /// No description provided for @autoEnhance.
  ///
  /// In en, this message translates to:
  /// **'Auto Enhance'**
  String get autoEnhance;

  /// No description provided for @resetAdjustments.
  ///
  /// In en, this message translates to:
  /// **'Reset Adjustments'**
  String get resetAdjustments;

  /// No description provided for @saveChanges.
  ///
  /// In en, this message translates to:
  /// **'Save Changes'**
  String get saveChanges;

  /// No description provided for @discardChanges.
  ///
  /// In en, this message translates to:
  /// **'Discard Changes'**
  String get discardChanges;

  /// No description provided for @unsavedChanges.
  ///
  /// In en, this message translates to:
  /// **'You have unsaved changes'**
  String get unsavedChanges;

  /// No description provided for @saveBeforeLeaving.
  ///
  /// In en, this message translates to:
  /// **'Save before leaving?'**
  String get saveBeforeLeaving;

  /// No description provided for @changesSaved.
  ///
  /// In en, this message translates to:
  /// **'Changes saved'**
  String get changesSaved;

  /// No description provided for @changesDiscarded.
  ///
  /// In en, this message translates to:
  /// **'Changes discarded'**
  String get changesDiscarded;

  /// No description provided for @permissionRequired.
  ///
  /// In en, this message translates to:
  /// **'Permission Required'**
  String get permissionRequired;

  /// No description provided for @permissionRationale.
  ///
  /// In en, this message translates to:
  /// **'This app needs access to {permission} to function properly'**
  String permissionRationale(String permission);

  /// No description provided for @permissionDenied.
  ///
  /// In en, this message translates to:
  /// **'Permission Denied'**
  String get permissionDenied;

  /// No description provided for @permissionDeniedRationale.
  ///
  /// In en, this message translates to:
  /// **'This feature requires {permission} permission. Please enable it in your device settings.'**
  String permissionDeniedRationale(String permission);

  /// No description provided for @permissionNotGranted.
  ///
  /// In en, this message translates to:
  /// **'Permission not granted'**
  String get permissionNotGranted;

  /// No description provided for @allow.
  ///
  /// In en, this message translates to:
  /// **'Allow'**
  String get allow;

  /// No description provided for @deny.
  ///
  /// In en, this message translates to:
  /// **'Deny'**
  String get deny;

  /// No description provided for @openSettings.
  ///
  /// In en, this message translates to:
  /// **'Open Settings'**
  String get openSettings;

  /// No description provided for @cameraPermission.
  ///
  /// In en, this message translates to:
  /// **'Camera'**
  String get cameraPermission;

  /// No description provided for @storagePermission.
  ///
  /// In en, this message translates to:
  /// **'Storage'**
  String get storagePermission;

  /// No description provided for @locationPermission.
  ///
  /// In en, this message translates to:
  /// **'Location'**
  String get locationPermission;

  /// No description provided for @microphonePermission.
  ///
  /// In en, this message translates to:
  /// **'Microphone'**
  String get microphonePermission;

  /// No description provided for @notificationPermission.
  ///
  /// In en, this message translates to:
  /// **'Notifications'**
  String get notificationPermission;

  /// No description provided for @contactsPermission.
  ///
  /// In en, this message translates to:
  /// **'Contacts'**
  String get contactsPermission;

  /// No description provided for @calendarPermission.
  ///
  /// In en, this message translates to:
  /// **'Calendar'**
  String get calendarPermission;

  /// No description provided for @phonePermission.
  ///
  /// In en, this message translates to:
  /// **'Phone'**
  String get phonePermission;

  /// No description provided for @smsPermission.
  ///
  /// In en, this message translates to:
  /// **'SMS'**
  String get smsPermission;

  /// No description provided for @callLogPermission.
  ///
  /// In en, this message translates to:
  /// **'Call Log'**
  String get callLogPermission;

  /// No description provided for @bodySensorsPermission.
  ///
  /// In en, this message translates to:
  /// **'Body Sensors'**
  String get bodySensorsPermission;

  /// No description provided for @activityRecognitionPermission.
  ///
  /// In en, this message translates to:
  /// **'Activity Recognition'**
  String get activityRecognitionPermission;

  /// No description provided for @healthPermission.
  ///
  /// In en, this message translates to:
  /// **'Health Data'**
  String get healthPermission;

  /// No description provided for @bluetoothPermission.
  ///
  /// In en, this message translates to:
  /// **'Bluetooth'**
  String get bluetoothPermission;

  /// No description provided for @bluetoothScanPermission.
  ///
  /// In en, this message translates to:
  /// **'Bluetooth Scan'**
  String get bluetoothScanPermission;

  /// No description provided for @bluetoothConnectPermission.
  ///
  /// In en, this message translates to:
  /// **'Bluetooth Connect'**
  String get bluetoothConnectPermission;

  /// No description provided for @bluetoothAdvertisePermission.
  ///
  /// In en, this message translates to:
  /// **'Bluetooth Advertise'**
  String get bluetoothAdvertisePermission;

  /// No description provided for @nearbyWifiDevicesPermission.
  ///
  /// In en, this message translates to:
  /// **'Nearby Wi-Fi Devices'**
  String get nearbyWifiDevicesPermission;

  /// No description provided for @systemAlertWindowPermission.
  ///
  /// In en, this message translates to:
  /// **'System Alert Window'**
  String get systemAlertWindowPermission;

  /// No description provided for @writeSettingsPermission.
  ///
  /// In en, this message translates to:
  /// **'Write Settings'**
  String get writeSettingsPermission;

  /// No description provided for @drawOverOtherAppsPermission.
  ///
  /// In en, this message translates to:
  /// **'Draw Over Other Apps'**
  String get drawOverOtherAppsPermission;

  /// No description provided for @accessibilityPermission.
  ///
  /// In en, this message translates to:
  /// **'Accessibility'**
  String get accessibilityPermission;

  /// No description provided for @usageStatsPermission.
  ///
  /// In en, this message translates to:
  /// **'Usage Stats'**
  String get usageStatsPermission;

  /// No description provided for @deviceAdminPermission.
  ///
  /// In en, this message translates to:
  /// **'Device Admin'**
  String get deviceAdminPermission;

  /// No description provided for @bindNotificationListenerPermission.
  ///
  /// In en, this message translates to:
  /// **'Notification Listener'**
  String get bindNotificationListenerPermission;

  /// No description provided for @bindInputMethodPermission.
  ///
  /// In en, this message translates to:
  /// **'Input Method'**
  String get bindInputMethodPermission;

  /// No description provided for @bindAccessibilityServicePermission.
  ///
  /// In en, this message translates to:
  /// **'Accessibility Service'**
  String get bindAccessibilityServicePermission;

  /// No description provided for @bindDeviceAdminPermission.
  ///
  /// In en, this message translates to:
  /// **'Device Admin'**
  String get bindDeviceAdminPermission;

  /// No description provided for @bindNotificationAssistantServicePermission.
  ///
  /// In en, this message translates to:
  /// **'Notification Assistant'**
  String get bindNotificationAssistantServicePermission;

  /// No description provided for @bindVoiceInteractionServicePermission.
  ///
  /// In en, this message translates to:
  /// **'Voice Interaction'**
  String get bindVoiceInteractionServicePermission;

  /// No description provided for @bindTextServicePermission.
  ///
  /// In en, this message translates to:
  /// **'Text Service'**
  String get bindTextServicePermission;

  /// No description provided for @bindAutofillServicePermission.
  ///
  /// In en, this message translates to:
  /// **'Autofill Service'**
  String get bindAutofillServicePermission;

  /// No description provided for @bindContentSuggestionsServicePermission.
  ///
  /// In en, this message translates to:
  /// **'Content Suggestions'**
  String get bindContentSuggestionsServicePermission;

  /// No description provided for @bindCompanionDeviceServicePermission.
  ///
  /// In en, this message translates to:
  /// **'Companion Device'**
  String get bindCompanionDeviceServicePermission;

  /// No description provided for @bindInCallServicePermission.
  ///
  /// In en, this message translates to:
  /// **'In-Call Service'**
  String get bindInCallServicePermission;

  /// No description provided for @bindVisualVoicemailServicePermission.
  ///
  /// In en, this message translates to:
  /// **'Visual Voicemail'**
  String get bindVisualVoicemailServicePermission;

  /// No description provided for @bindNetworkScoreServicePermission.
  ///
  /// In en, this message translates to:
  /// **'Network Score'**
  String get bindNetworkScoreServicePermission;

  /// No description provided for @bindNetworkRecommendationServicePermission.
  ///
  /// In en, this message translates to:
  /// **'Network Recommendation'**
  String get bindNetworkRecommendationServicePermission;

  /// No description provided for @bindVpnServicePermission.
  ///
  /// In en, this message translates to:
  /// **'VPN Service'**
  String get bindVpnServicePermission;

  /// No description provided for @bindCarrierMessagingServicePermission.
  ///
  /// In en, this message translates to:
  /// **'Carrier Messaging'**
  String get bindCarrierMessagingServicePermission;

  /// No description provided for @bindCarrierServicesPermission.
  ///
  /// In en, this message translates to:
  /// **'Carrier Services'**
  String get bindCarrierServicesPermission;

  /// No description provided for @bindTelecomServicePermission.
  ///
  /// In en, this message translates to:
  /// **'Telecom Service'**
  String get bindTelecomServicePermission;

  /// No description provided for @bindCallScreeningServicePermission.
  ///
  /// In en, this message translates to:
  /// **'Call Screening'**
  String get bindCallScreeningServicePermission;

  /// No description provided for @bindCallRedirectionServicePermission.
  ///
  /// In en, this message translates to:
  /// **'Call Redirection'**
  String get bindCallRedirectionServicePermission;

  /// No description provided for @bindCallDiagnosticServicePermission.
  ///
  /// In en, this message translates to:
  /// **'Call Diagnostic'**
  String get bindCallDiagnosticServicePermission;

  /// No description provided for @bindCallLogProviderPermission.
  ///
  /// In en, this message translates to:
  /// **'Call Log Provider'**
  String get bindCallLogProviderPermission;

  /// No description provided for @bindContactsProviderPermission.
  ///
  /// In en, this message translates to:
  /// **'Contacts Provider'**
  String get bindContactsProviderPermission;

  /// No description provided for @bindDirectorySearchPermission.
  ///
  /// In en, this message translates to:
  /// **'Directory Search'**
  String get bindDirectorySearchPermission;

  /// No description provided for @bindAppWidgetPermission.
  ///
  /// In en, this message translates to:
  /// **'App Widget'**
  String get bindAppWidgetPermission;

  /// No description provided for @userNotFound.
  ///
  /// In en, this message translates to:
  /// **'User not found'**
  String get userNotFound;

  /// No description provided for @wrongPassword.
  ///
  /// In en, this message translates to:
  /// **'Wrong password'**
  String get wrongPassword;

  /// No description provided for @emailInUse.
  ///
  /// In en, this message translates to:
  /// **'Email already in use'**
  String get emailInUse;

  /// No description provided for @weakPassword.
  ///
  /// In en, this message translates to:
  /// **'Password is too weak'**
  String get weakPassword;

  /// No description provided for @errorOccurred.
  ///
  /// In en, this message translates to:
  /// **'An error occurred'**
  String get errorOccurred;

  /// No description provided for @enterEmail.
  ///
  /// In en, this message translates to:
  /// **'Enter email'**
  String get enterEmail;

  /// No description provided for @validEmail.
  ///
  /// In en, this message translates to:
  /// **'Please enter a valid email'**
  String get validEmail;

  /// No description provided for @enterPassword.
  ///
  /// In en, this message translates to:
  /// **'Enter password'**
  String get enterPassword;

  /// No description provided for @passwordLength.
  ///
  /// In en, this message translates to:
  /// **'Password must be at least 6 characters'**
  String get passwordLength;

  /// No description provided for @typeMessage.
  ///
  /// In en, this message translates to:
  /// **'Type a message...'**
  String get typeMessage;

  /// No description provided for @userTyping.
  ///
  /// In en, this message translates to:
  /// **'User is typing…'**
  String get userTyping;

  /// No description provided for @globalChat.
  ///
  /// In en, this message translates to:
  /// **'Global Chat'**
  String get globalChat;

  /// No description provided for @noMessagesYet.
  ///
  /// In en, this message translates to:
  /// **'No messages yet'**
  String get noMessagesYet;

  /// No description provided for @notLoggedIn.
  ///
  /// In en, this message translates to:
  /// **'Not logged in'**
  String get notLoggedIn;

  /// No description provided for @errorSendingMessage.
  ///
  /// In en, this message translates to:
  /// **'Error sending message'**
  String get errorSendingMessage;

  /// No description provided for @newMessage.
  ///
  /// In en, this message translates to:
  /// **'New Message'**
  String get newMessage;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['de', 'en', 'es'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'de':
      return AppLocalizationsDe();
    case 'en':
      return AppLocalizationsEn();
    case 'es':
      return AppLocalizationsEs();
  }

  throw FlutterError(
      'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
      'an issue with the localizations generation tool. Please file an issue '
      'on GitHub with a reproducible sample app and the gen-l10n configuration '
      'that was used.');
}
