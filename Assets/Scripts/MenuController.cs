using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;
using UnityEngine.SceneManagement;
public class MenuController : MonoBehaviour
{
    public Button menuButton;
    public Button statsButton;
    
    public Button homeButton;
    public Button newWordButton;

    public Button homeButtonMenu;
    public Button newWordButtonMenu;

    public Button closeMenuPanel;
    public Button closeStatsPanel;

    public GameObject menuPanel;
    public GameObject statsPanel;

    public TMPro.TextMeshProUGUI statusTextBox;
    public TMPro.TextMeshProUGUI wordTextBox;
    public TMPro.TextMeshProUGUI triesTextBox;
    public TMPro.TextMeshProUGUI timeTextBox;

    public GameObject wordDisplaySection;
    public GameObject currentGameScoreSection;
    public GameObject guessDistributionSection;
    public GameObject overallStatisticsSection;

    public TMPro.TextMeshProUGUI playedTextBox;
    public TMPro.TextMeshProUGUI winpcTextBox;
    public TMPro.TextMeshProUGUI currentStreakTextBox;
    public TMPro.TextMeshProUGUI maxStreakTextBox;

    public TMPro.TextMeshProUGUI scorePlayer1;
    public TMPro.TextMeshProUGUI scorePlayer2;

    public List<GameObject> graphBar=new List<GameObject>();

    // Start is called before the first frame update
    void Start()
    {
        Debug.Log("Answer Length is = " + PlayerController.answer_length);
        if (PlayerController.hacker_mode)
            addWordDetailsSection(PlayerController.answer);
        else
            wordDisplaySection.SetActive(false);
        if (PlayerController.ai_mode)
        {
            guessDistributionSection.SetActive(false);
            overallStatisticsSection.SetActive(false);

            scorePlayer1.text = CurrentGame.score_1.ToString();
            scorePlayer2.text = CurrentGame.score_2.ToString();
        }
        else
        {
            currentGameScoreSection.SetActive(false);
        }
        menuPanel.SetActive(false);
        //PlayerDeets.getStatisticsFromDb();
        setOverallStatistics();
        triesTextBox.SetText("-");
        timeTextBox.SetText("-");
        menuButton.GetComponent<Button>().onClick.AddListener(
                () => ToggleMenu()
            );
        statsButton.GetComponent<Button>().onClick.AddListener(
                () => ToggleStats()
            );

        homeButton.GetComponent<Button>().onClick.AddListener(
                () => GoHome()
            );
        newWordButton.GetComponent<Button>().onClick.AddListener(
                () => NewWord()
            );
        homeButtonMenu.GetComponent<Button>().onClick.AddListener(
                () => GoHome()
            );
        newWordButtonMenu.GetComponent<Button>().onClick.AddListener(
                () => NewWord()
            );
        closeMenuPanel.GetComponent<Button>().onClick.AddListener(
                () => ToggleMenu()
            );
        closeStatsPanel.GetComponent<Button>().onClick.AddListener(() => ToggleStats());
    }
    void ToggleMenu()
    {
        menuPanel.SetActive(!menuPanel.activeInHierarchy);
        statsPanel.SetActive(false);
    }
    void ToggleStats()
    {
        statsPanel.SetActive(!statsPanel.activeInHierarchy);
        menuPanel.SetActive(false);
    }
    private IEnumerator ToggleStatsInAWhile(float waitTime)
    {
        yield return new WaitForSeconds(waitTime);
        ToggleStats();
    }
    void GoHome()
    {
        SceneManager.LoadScene("MenuScene");
    }
    void NewWord()
    {
        SceneManager.LoadScene(SceneManager.GetActiveScene().name);
    }
    public void statusOnCompletion(bool status, float timer, int tries, string player)
    {
        addWordDetailsSection(PlayerController.answer);
        if (PlayerController.ai_mode)
        {
            scorePlayer1.text = CurrentGame.score_1.ToString();
            scorePlayer2.text = CurrentGame.score_2.ToString();
            if (status)
            {
                if (player == CurrentGame.player_1) { statusTextBox.text = "YOU WON!"; statusTextBox.color = new Color32(0, 150, 0, 255); }
                else if (player == CurrentGame.player_2) { statusTextBox.text = "YOU LOST!"; statusTextBox.color = new Color32(150, 0, 0, 255); }
                }
            else
            {
                statusTextBox.text = "DRAW!";
                statusTextBox.color = new Color32(150, 150, 150, 255);
            }
        }
        else
        {
            if (status)
            {
                statusTextBox.text = "YOU WON!";
                statusTextBox.color = new Color32(0, 150, 0, 255);
                triesTextBox.SetText(tries.ToString());
                timeTextBox.SetText(string.Format("{0:00}:{1:00}:{2:000}", Mathf.FloorToInt(timer / 60), Mathf.FloorToInt(timer % 60), Mathf.FloorToInt(timer % 1000)));
            }
            else
            {
                statusTextBox.text = "YOU LOST";
                statusTextBox.color = new Color32(150, 0, 0, 255);
                timeTextBox.SetText(string.Format("{0:00}:{1:00}:{2:000}", Mathf.FloorToInt(timer / 60), Mathf.FloorToInt(timer % 60), Mathf.FloorToInt(timer % 1000)));
            }
            setOverallStatistics();
        }
        StartCoroutine(ToggleStatsInAWhile(0.75f));
    }
    void setOverallStatistics()
    {
        // TODO: Write logic to get overall stats from playfab data
        Debug.Log("Setting the stats in Result Panel");
        int played,completed, current_streak_from_db, max_streak_from_db, win_pc;
        if (PlayerController.answer_length == 5)
        {
            played = PlayerDeets.played;
            completed = PlayerDeets.completed;
            current_streak_from_db = PlayerDeets.current_streak;
            max_streak_from_db = PlayerDeets.max_streak;
            win_pc = played > 0 ? (completed * 100) / played : 0;
        }
        else if (PlayerController.answer_length == 6)
        {
            played = PlayerDeets.played_6;
            completed = PlayerDeets.completed_6;
            current_streak_from_db = PlayerDeets.current_streak_6;
            max_streak_from_db = PlayerDeets.max_streak_6;
            win_pc = played > 0 ? (completed * 100) / played : 0;
        }
        else
        {
            Debug.Log("SetOverallStatistics not possible due to answer length problem");
            return;
        }
        
        //int current_streak = status ? current_streak_from_db + 1 : 0;
        //int max_streak = current_streak > max_streak_from_db ? current_streak : max_streak_from_db;

        playedTextBox.text = played.ToString();
        winpcTextBox.text=win_pc.ToString()+"%";
        currentStreakTextBox.text = current_streak_from_db.ToString();
        maxStreakTextBox.text = max_streak_from_db.ToString();

        setGuessDistribution();
    }
    void setGuessDistribution()
    {
        if (PlayerController.answer_length == 5)
        {
            int max = 0;
            for (int i = 0; i < PlayerDeets.guess_distribution.Count; i++)
            {
                if (PlayerDeets.guess_distribution[i] > max)
                {
                    max = PlayerDeets.guess_distribution[i];
                }
            }
            //30 for 0 plus max 620
            if (max > 0)
            {
                for (int i = 0; i < graphBar.Count - 1; i++)
                {
                    graphBar[i].transform.GetComponent<RectTransform>().sizeDelta = new Vector2(30 + PlayerDeets.guess_distribution[i] * 620 / max, 50);
                    graphBar[i].GetComponentInChildren<TMPro.TextMeshProUGUI>(true).text = PlayerDeets.guess_distribution[i].ToString();
                }
            }
            graphBar[graphBar.Count - 1].transform.parent.gameObject.SetActive(false);
            Debug.Log("6 level bar graph created");
            RectTransform parentSizeRectTransform = graphBar[graphBar.Count - 1].transform.parent.parent.parent.gameObject.GetComponent<RectTransform>();
            parentSizeRectTransform.sizeDelta = new Vector2(parentSizeRectTransform.sizeDelta.x, parentSizeRectTransform.sizeDelta.y - 100);
        }
        else if (PlayerController.answer_length == 6)
        {
            
            int max = 0;
            for (int i = 0; i < PlayerDeets.guess_distribution_6.Count; i++)
            {
                if (PlayerDeets.guess_distribution_6[i] > max)
                {
                    max = PlayerDeets.guess_distribution_6[i];
                }
            }
            //30 for 0 plus max 620
            if (max > 0)
            {
                for (int i = 0; i < graphBar.Count; i++)
                {
                    graphBar[i].transform.GetComponent<RectTransform>().sizeDelta = new Vector2(30 + PlayerDeets.guess_distribution_6[i] * 620 / max, 50);
                    graphBar[i].GetComponentInChildren<TMPro.TextMeshProUGUI>(true).text = PlayerDeets.guess_distribution_6[i].ToString();
                }
            }
            
            Debug.Log("7 level bar graph created");
        }
        else
        {
            Debug.Log("setGuessDistribution failed due to wrong answer length");
            return;
        }
        
        
    }
    void addWordDetailsSection(string word)
    {
        wordDisplaySection.SetActive(true);
        wordTextBox.text = word;
    }
}
