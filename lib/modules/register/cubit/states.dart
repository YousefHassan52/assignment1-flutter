abstract class AppStates {}
class InitialAppState extends AppStates{}

class CreateDatabaseTodoState extends AppStates{}
class UpdateDatabaseTodoState extends AppStates{}
class DeleteDatabaseTodoState extends AppStates{}
class InsertIntoDatabaseTodoSuccessState extends AppStates{}
class GetFromDatabaseTodoState extends AppStates{}
class ChangeBottomSheetTodoState extends AppStates{}
class ErrorInsertState extends AppStates{}
class ChangedradioState extends AppStates{}
class NullCompanyLocationState extends AppStates{}
class RepeatableUserData extends AppStates{}


class GetProfileDataLoadingState extends AppStates{}
class GetProfileDataSuccessState extends AppStates{}
class GetProfileDataErrorState extends AppStates{}


class DataUpdateErrorState extends AppStates{}
class DataUpdateSuccessState extends AppStates{}
class DataUpdateLoadingState extends AppStates{}


class ImagePickerSuccessSocialState extends AppStates{}
class ImagePickerErrorSocialState extends AppStates{}


class ServiceTableCreatedSuccessState extends AppStates{}
class ServiceTableCreatedErrorState extends AppStates{}

class InsertedToServicesTableSuccessState extends AppStates{}
class InsertedToServicesTableErrorState extends AppStates{}


