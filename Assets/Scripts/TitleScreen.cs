using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using PlayFab;
using PlayFab.ClientModels;
using UnityEngine.UI;
using UnityEngine.SceneManagement;

public static class PlayerDeets
{
    public static string PlayFabId;
    public static string SessionTicket;
    public static UserSettings SettingsForUser;
    public static string Username;
    //statistics
    public static int played;
    public static int completed;
    public static int current_streak;
    public static int max_streak;
    public static int avg_time;
    public static List<int> guess_distribution;

    public static int played_6;
    public static int completed_6;
    public static int current_streak_6;
    public static int max_streak_6;
    public static int avg_time_6;
    public static List<int> guess_distribution_6;

    public static void removeSavedDeets()
    {
        PlayFabId = "";
        SessionTicket = "";
        SettingsForUser = null;
        Username = "";

        played = 0;
        completed = 0;
        current_streak = 0;
        max_streak = 0;
        avg_time = 0;
        guess_distribution = null;

        played_6 = 0;
        completed_6 = 0;
        current_streak_6 = 0;
        max_streak_6 = 0;
        avg_time_6 = 0;
        guess_distribution_6 = null;

        PlayerPrefs.DeleteAll();
        Debug.Log("Playerdeets Discarded");
    }
    public static void SetAccountInfoResultonRegister(RegisterPlayFabUserResult result)
    {
        PlayFabId = result.PlayFabId;
        SessionTicket = result.SessionTicket;
        SettingsForUser = result.SettingsForUser;
        Username = result.Username;
        Debug.Log("User Settings set");
    }
    public static void SetAccountInfoResultonLogin(LoginResult result)
    {
        PlayFabId = result.PlayFabId;
        SessionTicket = result.SessionTicket;
        SettingsForUser = result.SettingsForUser;
        //Username = username;
        Debug.Log("User Settings set");
    }
    public static void SetAccountInfoResult()
    {
        GetAccountInfoResult();
        Debug.Log("User Settings set");
        PlayerPrefs.SetString("username", Username);
    }
    public static void GetAccountInfoResult()
    {
        Debug.Log("Feching account info");
        GetAccountInfoRequest request = new GetAccountInfoRequest();
        PlayFabClientAPI.GetAccountInfo(request, onAccountSuccess, onAccountError);
    }
    public static void onAccountSuccess(GetAccountInfoResult result)
    {
        Debug.Log("Account info fetching success");
        PlayFabId = result.AccountInfo.PlayFabId;
        Username = result.AccountInfo.Username;
    }
    public static void onAccountError(PlayFabError error)
    {
        Debug.Log("ERROR!" + error.GenerateErrorReport());
    }
    public static void autoLogin()
    {
        if (PlayerPrefs.HasKey("username") && PlayerPrefs.HasKey("password"))
        {
            //login_username.text = PlayerPrefs.GetString("username");
            //login_password.text = PlayerPrefs.GetString("password");
            var request = new LoginWithPlayFabRequest
            {
                Username = PlayerPrefs.GetString("username")
            ,
                Password = PlayerPrefs.GetString("password")
            };
            PlayFabClientAPI.LoginWithPlayFab(request, OnLoginSuccess, OnLoginError);
        }
    }
    public static void logout()
    {
        PlayFabClientAPI.ForgetAllCredentials();
        Debug.Log("Playfab forget Credentials called");
        removeSavedDeets();
        SceneManager.LoadScene("LoginScene");
    }
    public static void OnLoginSuccess(LoginResult result)
    {
        Debug.Log("Login API success");
        //Debug.Log(result.ToString());
        SetAccountInfoResultonLogin(result);
        //PlayerDeets.SetAccountInfoResult();
        SceneManager.LoadScene("MenuScene");
    }
    public static void OnLoginError(PlayFabError error)
    {
        Debug.Log("Login API fail");
        Debug.Log(error.GenerateErrorReport());
        /*if (error.ErrorDetails != null)
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
        }*/

    }
    public static void getStatisticsFromDb()
    {
        played = 0;
        completed = 0;
        current_streak = 0;
        max_streak = 0;
        avg_time = 0;
        guess_distribution = new List<int>() { 0, 0, 0, 0, 0, 0 };

        played_6 = 0;
        completed_6 = 0;
        current_streak_6 = 0;
        max_streak_6 = 0;
        avg_time_6 = 0;
        guess_distribution_6 = new List<int>() { 0, 0, 0, 0, 0, 0, 0 };
        PlayFabClientAPI.GetPlayerStatistics(
            new GetPlayerStatisticsRequest(),
            OnGetStatistics,
            error => Debug.LogError(error.GenerateErrorReport())
        );

    }
    public static void updateStatistics(bool status, int word_index, int answer_time, int answer_length)
    {
        //Debug.Log("Updating stats");
        if (answer_length == 5)
        {
            avg_time = (avg_time * played + answer_time) / (played + 1);
            //Debug.Log("avg_time=" + avg_time);
            played += 1;
            if (status)
            {
                completed += 1;
                current_streak += 1;
                max_streak = current_streak > max_streak ? current_streak : max_streak;
                guess_distribution[word_index - 1] = guess_distribution[word_index - 1] + 1;
            }
            else
            {
                current_streak = 0;
            }
            Debug.Log("Caling api for updating");
            //store this data on server
            PlayFabClientAPI.UpdatePlayerStatistics(new UpdatePlayerStatisticsRequest
            {
                // request.Statistics is a list, so multiple StatisticUpdate objects can be defined if required.
                Statistics = new List<StatisticUpdate> {
                    new StatisticUpdate { StatisticName = "played", Value = played },
                    new StatisticUpdate { StatisticName = "completed", Value = completed },
                    new StatisticUpdate { StatisticName = "current_streak", Value = current_streak },
                    new StatisticUpdate { StatisticName = "max_streak", Value = max_streak },
                    new StatisticUpdate { StatisticName = "avg_time", Value = avg_time },
                    new StatisticUpdate { StatisticName = "5_1_try", Value = guess_distribution[0] },
                    new StatisticUpdate { StatisticName = "5_2_try", Value = guess_distribution[1] },
                    new StatisticUpdate { StatisticName = "5_3_try", Value = guess_distribution[2] },
                    new StatisticUpdate { StatisticName = "5_4_try", Value = guess_distribution[3] },
                    new StatisticUpdate { StatisticName = "5_5_try", Value = guess_distribution[4] },
                    new StatisticUpdate { StatisticName = "5_6_try", Value = guess_distribution[5] }
                }
            },
                result => { Debug.Log("User statistics updated for length " + answer_length); },
                error => { Debug.LogError(error.GenerateErrorReport()); }
            );
        }
        else if (answer_length == 6)
        {
            avg_time_6 = (avg_time_6 * played_6 + answer_time) / (played_6 + 1);
            //Debug.Log("avg_time=" + avg_time);
            played_6 += 1;
            if (status)
            {
                completed_6 += 1;
                current_streak_6 += 1;
                max_streak_6 = current_streak_6 > max_streak_6 ? current_streak_6 : max_streak_6;
                guess_distribution_6[word_index - 1] = guess_distribution_6[word_index - 1] + 1;
            }
            else
            {
                current_streak_6 = 0;
            }
            Debug.Log("Caling api for updating");
            //store this data on server
            PlayFabClientAPI.UpdatePlayerStatistics(new UpdatePlayerStatisticsRequest
            {
                // request.Statistics is a list, so multiple StatisticUpdate objects can be defined if required.
                Statistics = new List<StatisticUpdate> {
                    new StatisticUpdate { StatisticName = "played_6", Value = played_6 },
                    new StatisticUpdate { StatisticName = "completed_6", Value = completed_6 },
                    new StatisticUpdate { StatisticName = "current_streak_6", Value = current_streak_6 },
                    new StatisticUpdate { StatisticName = "max_streak_6", Value = max_streak_6 },
                    new StatisticUpdate { StatisticName = "avg_time_6", Value = avg_time_6 },
                    new StatisticUpdate { StatisticName = "6_1_try", Value = guess_distribution_6[0] },
                    new StatisticUpdate { StatisticName = "6_2_try", Value = guess_distribution_6[1] },
                    new StatisticUpdate { StatisticName = "6_3_try", Value = guess_distribution_6[2] },
                    new StatisticUpdate { StatisticName = "6_4_try", Value = guess_distribution_6[3] },
                    new StatisticUpdate { StatisticName = "6_5_try", Value = guess_distribution_6[4] },
                    new StatisticUpdate { StatisticName = "6_6_try", Value = guess_distribution_6[5] },
                    new StatisticUpdate { StatisticName = "6_7_try", Value = guess_distribution_6[6] }
                }
            },
                result => { Debug.Log("User statistics updated for length " + answer_length); },
                error => { Debug.LogError(error.GenerateErrorReport()); }
            );
        }
        else
        {
            Debug.Log("Unknown answer length. Cant update statistics!");
        }

    }

    static void OnGetStatistics(GetPlayerStatisticsResult result)
    {
        //Debug.Log("Received the following Statistics:");
        foreach (var eachStat in result.Statistics)
        {
            //Debug.Log("Statistic (" + eachStat.StatisticName + "): " + eachStat.Value);
            switch (eachStat.StatisticName)
            {
                case "played":
                    played = eachStat.Value;
                    break;
                case "completed":
                    completed = eachStat.Value;
                    break;
                case "current_streak":
                    current_streak = eachStat.Value;
                    break;
                case "max_streak":
                    max_streak = eachStat.Value;
                    break;
                case "avg_time":
                    avg_time = eachStat.Value;
                    break;
                case "5_1_try":
                    guess_distribution[0] = eachStat.Value;
                    break;
                case "5_2_try":
                    guess_distribution[1] = eachStat.Value;
                    break;
                case "5_3_try":
                    guess_distribution[2] = eachStat.Value;
                    break;
                case "5_4_try":
                    guess_distribution[3] = eachStat.Value;
                    break;
                case "5_5_try":
                    guess_distribution[4] = eachStat.Value;
                    break;
                case "5_6_try":
                    guess_distribution[5] = eachStat.Value;
                    break;
                case "played_6":
                    played_6 = eachStat.Value;
                    break;
                case "completed_6":
                    completed_6 = eachStat.Value;
                    break;
                case "current_streak_6":
                    current_streak_6 = eachStat.Value;
                    break;
                case "max_streak_6":
                    max_streak_6 = eachStat.Value;
                    break;
                case "avg_time_6":
                    avg_time_6 = eachStat.Value;
                    break;
                case "6_1_try":
                    guess_distribution_6[0] = eachStat.Value;
                    break;
                case "6_2_try":
                    guess_distribution_6[1] = eachStat.Value;
                    break;
                case "6_3_try":
                    guess_distribution_6[2] = eachStat.Value;
                    break;
                case "6_4_try":
                    guess_distribution_6[3] = eachStat.Value;
                    break;
                case "6_5_try":
                    guess_distribution_6[4] = eachStat.Value;
                    break;
                case "6_6_try":
                    guess_distribution_6[5] = eachStat.Value;
                    break;
                case "6_7_try":
                    guess_distribution_6[6] = eachStat.Value;
                    break;
                default:
                    Debug.Log("This statistic variable is either not there or its not set =>" + eachStat.StatisticName);
                    break;
            }
        }

    }

}

public class TitleScreen : MonoBehaviour
{
    public TMPro.TextMeshProUGUI login_error;
    // Start is called before the first frame update
    void Start()
    {
        Debug.Log("Title Screen");
        if (Application.platform == RuntimePlatform.Android)
        {
            Debug.Log("Android platform auto login using device ID");
            var request = new LoginWithAndroidDeviceIDRequest
            {
                AndroidDeviceId = SystemInfo.deviceUniqueIdentifier,
                CreateAccount =true,
            };
            PlayFabClientAPI.LoginWithAndroidDeviceID(request,OnLoginSuccess,OnLoginError);
            return;
        }
        else
        {
            Debug.Log("Android platform auto login yothisatest device ID");
            var request = new LoginWithAndroidDeviceIDRequest
            {
                AndroidDeviceId = "yothisatest",
                CreateAccount = true,
            };
            PlayFabClientAPI.LoginWithAndroidDeviceID(request, OnLoginSuccess, OnLoginError);
            return;
        }
    }

    void OnLoginSuccess(LoginResult result)
    {
        Debug.Log("Login API success");
        //Debug.Log(result.ToString());
        PlayerDeets.SetAccountInfoResultonLogin(result);
        //PlayerDeets.SetAccountInfoResult();
        Debug.Log("Going to menu scene as login was successful");
        SceneManager.LoadScene("MenuScene");
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
}
