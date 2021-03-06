class ResponseStatus
{
   int _error;
   String _message;
   String _user;
   String _data;


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

   String getUser() {
    return _user;
  }

   void setUser(String user) {
    this._user = user;
  }

   String getData() {
    return _data;
  }

   void setData(String data) {
    this._data = data;
  }
}