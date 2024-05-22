abstract class Social_States {}

class InitialState extends Social_States {}

class GetUserLoadingState extends Social_States {}

class GetUserSuccessState extends Social_States {}

class GetUserErrorState extends Social_States {
  final String error;
  GetUserErrorState({required this.error});
}

class FeedsBottomNavState extends Social_States {}

class ChatBottomNavState extends Social_States {}

class userBottomNavState extends Social_States {}

class SettingsBottomNavState extends Social_States {}

class PickedImageProfileState extends Social_States {}

class NotPickedImageProfileState extends Social_States {}

class PickedImageCoverState extends Social_States {}

class NotPickedImageCoverState extends Social_States {}

class uploadprofileimagesuccessState extends Social_States {}

class uploadprofileimageerrorState extends Social_States {}

class uploadcoverimagesuccessState extends Social_States {}

class uploadcoverimageerrorState extends Social_States {}

class UpdateloadingState extends Social_States {}

class UpdateerrorState extends Social_States {}

class createpostsuccessState extends Social_States {}

class createpostloadingState extends Social_States {}

class createposterrorState extends Social_States {}

class PickedImagePostState extends Social_States {}

class NotPickedImagePostState extends Social_States {}

class RemovepostimageState extends Social_States {}

class getPostSuccessState extends Social_States {}

class getPostLoadingState extends Social_States {}

class getPostErrorState extends Social_States {}

class likePostSuccessState extends Social_States {}

class likePostErrorState extends Social_States {}

class commentPostSuccessState extends Social_States {}

class commentPostErrorState extends Social_States {}

class createcommentSuccessState extends Social_States {}

class createcommentErrorState extends Social_States {}

class createcommentLoadingState extends Social_States {}

class getcommentSuccessState extends Social_States {}

class getcommentLoadingState extends Social_States {}

class getcommentErrorState extends Social_States {}

class getcommentcountSuccessState extends Social_States {}

class getcommentcountLoadingState extends Social_States {}

class getcommentcountErrorState extends Social_States {}

class nocommentsState extends Social_States {}

class getpostidsuccessState extends Social_States {}

class getpostiderrorState extends Social_States {}

class GetallUserLoadingState extends Social_States {}

class GetallUserSuccessState extends Social_States {}

class GetallUserErrorState extends Social_States {
  final String error;
  GetallUserErrorState(this.error);
}

class sendmessageSuccessState extends Social_States {}

class sendmessageerrorState extends Social_States {}

class getmessagesuccessState extends Social_States {}

class getmessageErrorState extends Social_States {}

class uploadsendimageSuccessState extends Social_States {}

class uploadsendimageLoadingState extends Social_States {}

class uploadsendimageErrorState extends Social_States {}

class pickedsendimageeerrorState extends Social_States {}

class pickedsendimagesuccessState extends Social_States {}
