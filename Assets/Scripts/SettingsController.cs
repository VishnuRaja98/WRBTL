using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;
using UnityEngine.SceneManagement;

public class SettingsController : MonoBehaviour
{
    public Button openSettings;
    public Button closeSettings;

    public GameObject settingsPanel;

    public GameObject loginObject;
    public GameObject registerObject;

    public Button loginButton;
    public Button gotoRegisterButton;
    public Button gotoLoginButton;
    public Button registerButton;

    public TMPro.TMP_InputField login_username;
    public TMPro.TMP_InputField login_password;

    public TMPro.TMP_InputField register_username;
    public TMPro.TMP_InputField register_password;
    public TMPro.TMP_InputField register_password2;
    
    public TMPro.TextMeshProUGUI register_error;
    public TMPro.TextMeshProUGUI login_error;

    // Start is called before the first frame update
    void Start()
    {
        if (PlayerDeets.Username == null || PlayerDeets.Username == "")
        {
            gotoView("register");
        }
        SetupButtons();
    }

    void SetupButtons()
    {
        openSettings.GetComponent<Button>().onClick.AddListener(() => toggleSettigns(true));
        closeSettings.GetComponent<Button>().onClick.AddListener(() => toggleSettigns(false));

        gotoLoginButton.GetComponent<Button>().onClick.AddListener(() => gotoView("login"));
        gotoRegisterButton.GetComponent<Button>().onClick.AddListener(() => gotoView("register"));
        registerButton.GetComponent<Button>().onClick.AddListener(() => Register());
        loginButton.GetComponent<Button>().onClick.AddListener(() => Login());
    }
    void toggleSettigns(bool state)
    {
        Debug.Log("Toggle Settings Called"+state);
        settingsPanel.SetActive(state);
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
            /*var request = new RegisterPlayFabUserRequest
            {
                Username = register_username.text
                ,
                Password = register_password.text
                ,
                RequireBothUsernameAndEmail = false
            };
            PlayFabClientAPI.RegisterPlayFabUser(request, onRegisterSuccess, onRegisterError);*/
        }
    }
    void Login()
    {
        Debug.Log("Login Button Clicked");
        Debug.Log("Username=" + login_username.text);
        Debug.Log("Password=" + login_password.text);
        //PlayFabClientAPI.LoginWithPlayFab(request, OnLoginSuccess, OnLoginError);
        //var request = new LoginWithCustomIDRequest
        //{
        //    CustomId = SystemInfo.deviceUniqueIdentifier
        //    ,CreateAccount = true
        //};
        //PlayFabClientAPI.LoginWithCustomID(request, OnLoginSuccess, OnLoginError);

    }


}
