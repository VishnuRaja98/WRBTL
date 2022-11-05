using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using PlayFab;
using PlayFab.ClientModels;
using UnityEngine.UI;
using UnityEngine.SceneManagement;


public class PlayfabManager : MonoBehaviour
{
    public Button loginButton;
    public Button gotoRegisterButton;
    public Button gotoLoginButton;
    public Button registerButton;
    public Button forgotPasswordButton;
    public TMPro.TMP_InputField login_username;
    public TMPro.TMP_InputField login_password;
    public TMPro.TMP_InputField register_username;
    public TMPro.TMP_InputField register_password;
    public TMPro.TMP_InputField register_password2;
    public GameObject loginObject;
    public GameObject registerObject;
    public TMPro.TextMeshProUGUI register_error;
    public TMPro.TextMeshProUGUI login_error;
    public Toggle rememberMe;
    // Start is called before the first frame update
    void Start()
    {
        autoLogin();
        SetupButtons();
        //Login();  
    }
    void SetupButtons()
    {
        gotoLoginButton.GetComponent<Button>().onClick.AddListener(() => gotoView("login"));
        gotoRegisterButton.GetComponent<Button>().onClick.AddListener(() => gotoView("register"));
        forgotPasswordButton.GetComponent<Button>().onClick.AddListener(() => Debug.Log("Need to develop this forgot password piece!"));
        registerButton.GetComponent<Button>().onClick.AddListener(() => Register());
        loginButton.GetComponent<Button>().onClick.AddListener(() => Login());
    }

    void gotoView(string obj)
    {
        switch (obj)
        {
            case "login":
                loginObject.SetActive(true);
                registerObject.SetActive(false);
                break;
            case "register":
                loginObject.SetActive(false);
                registerObject.SetActive(true);
                break;
            case "menu":
                Debug.Log("Loading Menu");
                SceneManager.LoadScene("MenuScene");
                break;
            default:
                Debug.Log("Key " + obj + " not found to go to");
                break;
        }
    }

    void Register()
    {
        register_error.text = "";
        Debug.Log("Register button Clicked");
        Debug.Log("Username=" + register_username.text);
        Debug.Log("Password=" + register_password.text);
        Debug.Log("Password2=" + register_password2.text);
        if (register_password.text != register_password2.text)
        {
            Debug.Log("Passwords Dont match");
        }
        else
        {
            Debug.Log("Passwords Match");
            var request = new RegisterPlayFabUserRequest
            {
                Username = register_username.text
                ,Password = register_password.text
                ,RequireBothUsernameAndEmail=false
            };
            PlayFabClientAPI.RegisterPlayFabUser(request, onRegisterSuccess, onRegisterError);
        }
    }
    // Update is called once per frame
    void autoLogin()
    {
        /*if (Application.platform == RuntimePlatform.Android)
        {
            Debug.Log("Android platform auto login using device ID");
            var request = new LoginWithAndroidDeviceIDRequest();
            PlayFabClientAPI.LoginWithAndroidDeviceID(request,OnLoginSuccess,OnLoginError);
            return;
        }*/
        if (PlayerPrefs.HasKey("username") && PlayerPrefs.HasKey("password"))
        {
            login_username.text = PlayerPrefs.GetString("username");
            login_password.text = PlayerPrefs.GetString("password");
            var request = new LoginWithPlayFabRequest
            {
                Username = PlayerPrefs.GetString("username")
            ,
                Password = PlayerPrefs.GetString("password")
            };
            PlayFabClientAPI.LoginWithPlayFab(request, OnLoginSuccess, OnLoginError);
        }
    }
    void Login()
    {
        Debug.Log("Login Button Clicked");
        var request = new LoginWithPlayFabRequest
        {
            Username = login_username.text
            ,
            Password = login_password.text
        };
        if (rememberMe.isOn)
        {
            PlayerPrefs.SetString("username", login_username.text);
            PlayerPrefs.SetString("password", login_password.text);
            PlayerPrefs.Save();
        }
        PlayFabClientAPI.LoginWithPlayFab(request, OnLoginSuccess, OnLoginError);
        //var request = new LoginWithCustomIDRequest
        //{
        //    CustomId = SystemInfo.deviceUniqueIdentifier
        //    ,CreateAccount = true
        //};
        //PlayFabClientAPI.LoginWithCustomID(request, OnLoginSuccess, OnLoginError);

    }
    void OnLoginSuccess(LoginResult result)
    {
        Debug.Log("Login API success");
        //Debug.Log(result.ToString());
        PlayerDeets.SetAccountInfoResultonLogin(result);
        //PlayerDeets.SetAccountInfoResult();
        gotoView("menu");
    }
    void OnLoginError(PlayFabError error)
    {
        Debug.Log("Login API fail");
        Debug.Log(error.GenerateErrorReport());
        if (error.ErrorDetails != null)
        {
            List<string> errors = new List<string>();
            foreach (var pair in error.ErrorDetails)
                foreach (var msg in pair.Value)
                    errors.Add(pair.Key + ": " + msg);
            login_error.text = errors[0];
        }
        else
        {
            login_error.text = error.ErrorMessage;
        }
           
    }

    void onRegisterSuccess(RegisterPlayFabUserResult result)
    {
        Debug.Log("Regiser API success");
        //Debug.Log(result.ToString());
        PlayerDeets.SetAccountInfoResultonRegister(result);
        //PlayerDeets.SetAccountInfoResult();
        gotoView("menu");
    }
    void onRegisterError(PlayFabError error)
    {
        Debug.Log("Regiser API fail");
        Debug.Log(error.GenerateErrorReport());
        if (error.ErrorDetails != null)
        {
            List<string> errors = new List<string>();
            foreach (var pair in error.ErrorDetails)
                foreach (var msg in pair.Value)
                    errors.Add(pair.Key + ": " + msg);
            register_error.text = errors[0];
        }
        else
        {
            register_error.text = error.ErrorMessage;
        }
    }

    
}
