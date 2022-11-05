using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;
using UnityEngine.SceneManagement;
using PlayFab;
using PlayFab.ClientModels;

public class MenuControl : MonoBehaviour
{
    public Button play5Button;
    public Button play5HackerButton;
    public Button play5AIButton;
    public Button play6Button;
    public Button play6HackerButton;
    public Button play6AIButton;

    public Button logoutButton;
    public TMPro.TextMeshProUGUI playerUsernameDisplay;
    public GameObject menuCanvas;


    readonly int animatorTriggerLoggedIn = Animator.StringToHash("loggedin");
    Animator animator = null;
    // Start is called before the first frame update
    void Start()
    {
        animator = menuCanvas.GetComponent<Animator>();
        animator.SetTrigger(animatorTriggerLoggedIn);
        if (PlayerDeets.SessionTicket == "" || PlayerDeets.SessionTicket == null)
        {
            //SceneManager.LoadScene("LoginScene");
            SceneManager.LoadScene("DirectLogin");
            return;
        }
        PlayerController.answer_length = 0;
        Debug.Log("Menu Loaded");
        PlayerDeets.getStatisticsFromDb();
        //Debug.Log("Statistics Loaded. Played = "+PlayerDeets.played);
        playerUsernameDisplay.text = PlayerDeets.PlayFabId;
        play5Button.GetComponent<Button>().onClick.AddListener(() => playSoloGame(5,false));
        play5HackerButton.GetComponent<Button>().onClick.AddListener(() => playSoloGame(5,true));
        play5AIButton.GetComponent<Button>().onClick.AddListener(() => playSoloGame(5, false, true));

        play6Button.GetComponent<Button>().onClick.AddListener(() => playSoloGame(6, false));
        play6HackerButton.GetComponent<Button>().onClick.AddListener(() => playSoloGame(6, true));
        play6AIButton.GetComponent<Button>().onClick.AddListener(() => playSoloGame(6, false, true));

        logoutButton.GetComponent<Button>().onClick.AddListener(() => PlayerDeets.logout());
    }

    void playSoloGame(int answer_length=5,bool hacker_mode=false,bool ai_mode=false)
    {
        PlayerController.answer_length = answer_length;
        PlayerController.hacker_mode = hacker_mode;
        PlayerController.ai_mode = ai_mode;
        if (ai_mode) CurrentGame.setupGame("YOU", "AI");
        SceneManager.LoadScene("GameScene");
    }
}
