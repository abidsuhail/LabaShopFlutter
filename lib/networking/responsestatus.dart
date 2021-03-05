class ResponseStatus
{
   int _error;
   String _message;
   Map<String,dynamic> _user;
   Map<String,dynamic> _data;


   int getError() {
    return _error;
  }

   void setError(int error) {
    this._error = error;
  }

   String getMessage() {
    return _message;
  }

   void setMessage(String message) {
    this._message = message;
  }

   Map<String,dynamic> getUser() {
    return _user;
  }

   void setUser(Map<String,dynamic> user) {
    this._user = user;
  }

   Map<String,dynamic> getData() {
    return _data;
  }

   void setData(Map<String,dynamic> data) {
    this._data = data;
  }
}