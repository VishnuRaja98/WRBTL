using System.Collections;
using System.Collections.Generic;
using System.IO;
using UnityEngine;
using UnityEngine.UI;
using UnityEngine.Networking;
using UnityEngine.SceneManagement;
using System.Text.RegularExpressions;

public static class CurrentGame
{
    public static int score_1,score_2;
    public static string player_1, player_2;
    public static void resetGame()
    {
        score_1 = 0;
        score_2 = 0;
        player_1 = "";
        player_2 = "";
    }
    public static void setupGame(string player1, string player2)
    {
        score_1 = 0;
        score_2 = 0;
        player_1 = player1;
        player_2 = player2;
    }
    public static void updateScoreForPlayer(string player, bool solved)
    {
        if (player == player_1&&solved)
        {
            score_1 += 1;
        }else if (player == player_2 && solved)
        {
            score_2 += 1;
        }
    }
}
public enum GameMode
{
    solo5=1,
    solo5hacker =2,

    solo6 = 3,
    solo6hacker = 4,
    unknown =-1
}

public class PlayerController : MonoBehaviour
{
    public List<Button> keyboardCharacterButtons = new List<Button>();
    public List<WordBox> wordboxes = new List<WordBox>();
    public Button backspaceButton;
    public Button okButton;
    public TMPro.TextMeshProUGUI timerText;
    public TextAsset txtAsset5;
    public TextAsset txtAsset6;

    public MenuController menuController;

    public GameObject playSpace;

    private int inp_index;
    private int word_index;
    private List<Button> clickedButtons = new List<Button>();
    private string characterNames = "QWERTYUIOPASDFGHJKLZXCVBNM";
    public static List<string> dictionary = new List<string>();
    public static int dictionaryMode = 5;
    public static string answer;
    private float answer_time;
    private bool solved = false;
    private bool finish = false;
    
    private float timer = 0f;
    //public static GameMode gameMode;
    public static int answer_length = 5;
    public static bool hacker_mode = false;
    public static bool ai_mode = false;
    private int tries_allowed = 6;

    private float ai_speed = 30f;
    private List<string> ai_regex_helper = new List<string>();
    private Dictionary<string, int> letter_count_dict_for_ai = new Dictionary<string, int>();
    private string regexpStr;
    private Coroutine ai_coroutine = null;
    // Start is called before the first frame update
    void Start()
    {
        //TextAsset txtAsset = Resources.Load<TextAsset>("Words/words.txt");
        //dictionary = new List<string>(File.ReadAllLines("Assets/Words/words.txt"));
        //Debug.Log(txtAsset.dataSize);
        //Debug.Log(txtAsset.text);
        //Debug.Log("0th Element="+txtAsset.text.Split()[0]);
        if (PlayerDeets.SessionTicket == "" || PlayerDeets.SessionTicket == null)
        {
            //SceneManager.LoadScene("LoginScene");
            SceneManager.LoadScene("DirectLogin");
            return;
        }
        if (answer_length!=5 && answer_length!=6)
        {
            SceneManager.LoadScene("MenuScene");
            return;
        }
        setupAccoardingToGameMode();
        if (dictionary.Count == 0 || dictionaryMode!=answer_length)
        {
            if (answer_length == 5)
            {
                dictionary = new List<string>(txtAsset5.text.Split(','));
            }
            else if (answer_length == 6)
            {
                dictionary = new List<string>(txtAsset6.text.Split(','));
            }
            dictionaryMode = answer_length;
            Debug.Log("Loaded Dictionary for "+dictionaryMode+" letter words");
        }
        //PlayerDeets.getStatisticsFromDb();
        //Debug.Log("1st Element=" + txtAsset.text.Split()[1]);
        solved = false;
        finish = false;
        //Debug.Log("TEST|"+dictionary[2] +"|"+ dictionary.Contains(dictionary[2].ToLower()) + "|");
        //Debug.Log("TEST|" + dictionary[11] + "|" + dictionary.Contains(dictionary[11].ToLower()) + "|");
        
        Debug.Log("total words in dictionary="+dictionary.Count);
        answer = dictionary[Random.Range(0, dictionary.Count)].ToUpper();
        //answer = "CELLO";
        Debug.Log("ANSWER = " + answer);
        Debug.Log("TEST|" + answer + "|" + dictionary.Contains(answer) + "|");
        //Debug.Log("CUSTOM => " + ok_word("water"));
        SetupButtons();
        if(ai_mode)
            ai_coroutine = StartCoroutine(AIGuess());//default AIGuess is called, start_index is -1 by default
        inp_index = 0;
        word_index = 0;
        timer = 0;
    }
    void setupAccoardingToGameMode()
    {
        for (int i = 0; i < answer_length; i++)
        {
            ai_regex_helper.Add("A-Z");
        }
            
        if (answer_length == 5)
        {
            //load 30 squares, col contraint = 5, colx = 200, tries allowed =6
            //answer_length = 5;
            Debug.Log("setupAccoardingToGameMode for 5");
            tries_allowed = 6;
            GridLayoutGroup gridLayoutGroup = playSpace.transform.GetComponent<GridLayoutGroup>();
            gridLayoutGroup.cellSize= new Vector2(200,200);
            gridLayoutGroup.constraintCount = answer_length;
            for(int i = 0; i < answer_length * tries_allowed; i++)
            {
                wordboxes[i].transform.gameObject.SetActive(true);
            }
        }
        else if (answer_length == 6)
        {
            //load 36 squares, col contraint = 6, colx = 175, tries allowed =7
            //answer_length = 6;
            Debug.Log("setupAccoardingToGameMode for 6");
            tries_allowed = 7;
            GridLayoutGroup gridLayoutGroup = playSpace.transform.GetComponent<GridLayoutGroup>();
            gridLayoutGroup.cellSize = new Vector2(175, 175);
            gridLayoutGroup.constraintCount = answer_length;
            for (int i = 0; i < answer_length * tries_allowed; i++)
            {
                wordboxes[i].transform.gameObject.SetActive(true);
            }
        }
    }
    void SetupButtons()
    {
        for (int i = 0; i < keyboardCharacterButtons.Count; i++)
        {
            //Debug.Log(characterNames[i].ToString()+ " printing");
            keyboardCharacterButtons[i].transform.GetComponentInChildren<TMPro.TextMeshProUGUI>().SetText(characterNames[i].ToString());
        }
        foreach (Button keyboardButton in keyboardCharacterButtons)
        {
            keyboardButton.GetComponent<Button>().onClick.AddListener(
                () => ClickLetter(keyboardButton.transform.GetComponentInChildren<TMPro.TextMeshProUGUI>().text, keyboardButton)
            );
        }
        backspaceButton.GetComponent<Button>().onClick.AddListener(
                () => Backspace()
            );
        okButton.GetComponent<Button>().onClick.AddListener(
                () => Enter(CurrentGame.player_1)
            );
        
    }
    void ClickLetter(string letter, Button button)
    {
        if(inp_index < answer_length && word_index < tries_allowed)
        {
            wordboxes[answer_length * word_index + inp_index].GetComponentInChildren<TMPro.TextMeshProUGUI>().SetText(letter);
            clickedButtons.Add(button);
            inp_index += 1;
        }
    }
    void Backspace()
    {
        if (inp_index > 0)
        {
            inp_index -= 1;
            wordboxes[answer_length * word_index + inp_index].GetComponentInChildren<TMPro.TextMeshProUGUI>().SetText("");
            clickedButtons.RemoveAt(inp_index);
        }
    }
    IEnumerator EnterWordFromAI(string word, int firstWordboxIndex)
    {
        Debug.Log("Word FOUND == " + word + " IT has length = " +word.Length);
        clickedButtons.Clear();
        for (int i = 0; i < answer_length; i++)
        {
            wordboxes[i+firstWordboxIndex].GetComponentInChildren<TMPro.TextMeshProUGUI>().SetText(word[i].ToString());
            clickedButtons.Add(keyboardCharacterButtons[characterNames.IndexOf(word[i])]);
        }
        inp_index = answer_length;
        Enter(CurrentGame.player_2);
        yield return null;
    }
    void Enter(string player=null)
    {
        if (inp_index == answer_length)
        {
            if (checkword())
            {
                inp_index = 0;
                word_index += 1;
                clickedButtons.Clear();
                if (finish)
                {
                    if(!(hacker_mode||ai_mode))
                        PlayerDeets.updateStatistics(solved,word_index,(int)answer_time, answer_length);
                    if (ai_mode)
                    {
                        CurrentGame.updateScoreForPlayer(player, solved);
                    }
                    menuController.statusOnCompletion(solved, answer_time, word_index, player); 
                }
            }
        }
    }
    bool checkword()
    {
        if(ai_mode)
            StopCoroutine(ai_coroutine); // need to check what happens if ai is not running!!!
        int[] final_states = new int[answer_length];
        for (int i = 0; i < final_states.Length; i++) final_states[i] = 0;
        bool[] used_input = new bool[answer_length];
        for (int i = 0; i < used_input.Length; i++) used_input[i] = false;
        bool[] used_answer = new bool[answer_length];
        for (int i = 0; i < used_answer.Length; i++) used_answer[i] = false;
        string word="";
        for(int i = 0; i < inp_index; i++)
        {
            word += wordboxes[answer_length * word_index + i].GetComponentInChildren<TMPro.TextMeshProUGUI>().text;
        }
        Debug.Log("Entered Word "+word);
        if (!dictionary.Contains(word))
        {
            //Debug.Log(dictionary[0].GetType()+"|"+word.GetType());
            //Debug.Log("TEST|" + word.ToLower() + "|" + dictionary.Contains(word.ToLower()) + "|");
            //Debug.Log("Word not found "+word.ToLower());
            for (int i = 0; i < inp_index; i++)
            {
                wordboxes[answer_length * word_index + i].Shake();
            }
            return false;
        }
        if (word == answer)
        {
            solved = true;
            finish = true;
            answer_time = timer;
            Debug.Log("Answer time=" + answer_time);
            Debug.Log("Guesses=" + (word_index+1));
        }
        if (word_index == (tries_allowed-1) && word != answer) //we put tries_allowed - 1 as the word index is starting from 0
        {
            finish = true;
            solved = false;
            answer_time = timer;
        }
        StartCoroutine(GetRequest("https://api.dictionaryapi.dev/api/v2/entries/en/" + word));
        //Debug.Log("Word=" + word+ ", exp ans="+answer);
        for (int i = 0; i < inp_index; i++)
        {
            if (word[i] == answer[i])
            {
                final_states[i] = 2;
                used_input[i] = true;
                used_answer[i] = true;
            }
            else
            {
                final_states[i] = -1;
            }
        }
        for(int i = 0; i < inp_index; i++)
        {
            for(int j = 0; j < inp_index; j++)
            {
                if (word[i] == answer[j] && (!used_answer[j]) && (!used_input[i]))
                {
                    final_states[i] = 1;
                    used_input[i] = true;
                    used_answer[j] = true;
                    j = inp_index;
                }
            }
        }
        for (int i = 0; i < inp_index; i++)
        {
            //wordboxes[5 * word_index + i].setState(final_states[i]);
            //changeBoxByState(wordboxes[answer_length * word_index + i], final_states[i]);
            StartCoroutine(changeBoxByStateBg(answer_length * word_index, answer_length * word_index + answer_length - 1, final_states));
        }
        changeButtonsByState(clickedButtons, final_states);
        if (!finish&&ai_mode)
            ai_coroutine = StartCoroutine(AIGuess(answer_length * word_index, answer_length * word_index + answer_length - 1, final_states));
        return true;
    }
    void changeBoxByState(WordBox box, int state)
    {
        if (state == -1)
        {
            //Image[] items = box.GetComponentsInChildren<Image>();
            //Debug.Log("nothere animation");
            box.setState((int)LetterState.notthere);
        }
        if (state == 1)
        {
            //Image[] items = box.GetComponentsInChildren<Image>();
            //foreach (Image item in items)
            //{
            //item.color = new Color32(180, 150, 0, 255);
            //Debug.Log("nearby animation");
            box.setState((int)LetterState.nearby);
            //}
        }
        if (state == 2)
        {
            //Image[] items = box.GetComponentsInChildren<Image>();
            //foreach (Image item in items)
            //{
            //item.color = new Color32(0, 150, 0, 255);
            //}
            //Debug.Log("correct animation");
            box.setState((int)LetterState.correct);
        }
    }

    private IEnumerator changeBoxByStateBg(int start_index, int end_index, int[] final_states)
    {
        for(int i = start_index; i <= end_index; i++)
        {
            changeBoxByState(wordboxes[i], final_states[i - start_index]);
            yield return new WaitForSeconds(.1f);
        }
    }
    void changeButtonsByState(List<Button> buttons, int[] states)
    {
        for(int i = 0; i < inp_index; i++)
        {
            if (states[i] == -1)
            {
                Image item = buttons[i].transform.GetComponentInChildren<Image>();
                if (item.color != new Color32(0, 150, 0, 255))
                {
                    item.color = new Color32(50, 50, 50, 255);
                }
            }
        }
        for (int i = 0; i < inp_index; i++)
        {
            if (states[i] == 2)
            {
                Image item = buttons[i].transform.GetComponentInChildren<Image>();
                item.color = new Color32(0, 150, 0, 255);
            }
        }
        for (int i = 0; i < inp_index; i++)
        {
            if (states[i] == 1)
            {
                Image item = buttons[i].transform.GetComponentInChildren<Image>();
                if (item.color != new Color32(0, 150, 0, 255))
                {
                    item.color = new Color32(180, 150, 0, 255);
                }
            }
        }
    }

    

    IEnumerator GetRequest(string uri)
    {
        using (UnityWebRequest webRequest = UnityWebRequest.Get(uri))
        {
            // Request and wait for the desired page.
            yield return webRequest.SendWebRequest();
            string[] pages = uri.Split('/');
            int page = pages.Length - 1;

            switch (webRequest.result)
            {
                case UnityWebRequest.Result.ConnectionError:
                case UnityWebRequest.Result.DataProcessingError:
                    Debug.LogError(pages[page] + ": Error: " + webRequest.error);
                    break;
                case UnityWebRequest.Result.ProtocolError:
                    Debug.LogError(pages[page] + ": HTTP Error: " + webRequest.error);
                    break;
                case UnityWebRequest.Result.Success:
                    string text = webRequest.downloadHandler.text;
                    text = text.Substring(1, text.Length - 1);
                    Debug.Log(pages[page] + ":\nReceived: " + text);
                    break;
            }
        }
    }
    private float getAITime()
    {
       return Random.Range((float)ai_speed/5, (float)ai_speed);
    }
    void updateLetterCount(Dictionary<string,int> thisWordDist)
    {
        foreach (KeyValuePair<string, int> entry in thisWordDist)
        {
            if (letter_count_dict_for_ai.ContainsKey(entry.Key)&&letter_count_dict_for_ai[entry.Key]<entry.Value)
            {
                letter_count_dict_for_ai[entry.Key] = entry.Value;
            }
            else if(!letter_count_dict_for_ai.ContainsKey(entry.Key))
            {
                letter_count_dict_for_ai.Add(entry.Key, entry.Value);
            }
        }
    }
    bool checkLetterCountsInWord(string word)
    {
        foreach (KeyValuePair<string, int> entry in letter_count_dict_for_ai)
        {
            if (word.Split(entry.Key).Length - 1 < entry.Value)
            {
                return false;
            }
        }
        return true;
    }
    void setAIRegexByState(int start_index, int end_index, int[] final_states)
    {

       // dont use A-Z regex after the first iteration
        for (int j = 0; j < answer_length; j++)
        {
            if (ai_regex_helper[j]=="A-Z")
            {
                ai_regex_helper[j] = "^,";
            }
        }

        Dictionary<string, int> thisWordDict = new Dictionary<string, int>();

        for (int i = start_index; i <= end_index; i++)
        {
            string letter = wordboxes[i].GetComponentInChildren<TMPro.TextMeshProUGUI>().text;
            int k = i - start_index;
            if (final_states[k]== -1)
            {
                for(int j = 0; j < answer_length; j++)
                {
                    if (ai_regex_helper[j].StartsWith("^"))
                    {
                        ai_regex_helper[j] += letter;
                    }
                }
            }
            else if(final_states[k] == 1)
            {
                if (ai_regex_helper[k].StartsWith("^"))
                {
                    ai_regex_helper[k] += letter;
                }
            }
            else if(final_states[k] == 2)
            {
                ai_regex_helper[k] = letter;
            }
            else
            {
                Debug.Log("Error , shouldnt be here");
            }
            if(final_states[k]==1 || final_states[k] == 2)
            {
                if (thisWordDict.ContainsKey(letter))
                {
                    thisWordDict[letter] += 1;
                }
                else
                {
                    thisWordDict.Add(letter, 1);
                }
            }
            updateLetterCount(thisWordDict);
        }
    }
    private IEnumerator AIGuess(int start_index=-1, int end_index=-1, int[] final_states=null) //default values called for 1st iteration as we have prebuilt regex for that
    {
        Debug.Log("AIGuess Started from "+ start_index.ToString()+" to "+end_index.ToString());
        if(start_index!=-1)
            setAIRegexByState(start_index, end_index, final_states);
        
        regexpStr = "";
        for (int i = 0; i < answer_length; i++)
            regexpStr = regexpStr + "["+ ai_regex_helper[i] + "]";
        Regex regexp = new Regex(@""+regexpStr);
        Debug.Log("Regex applied = " + regexpStr);
        MatchCollection results = regexp.Matches("");
        if (answer_length == 5)
            results = regexp.Matches(txtAsset5.text);
        else if (answer_length == 6)
            results = regexp.Matches(txtAsset6.text);
        /*for(int i = 0; i < 5; i++)
        {
            if(i<results.Count)
                Debug.Log("Matched " + results[i]);
        }*/
        Debug.Log("Total Matches for AI = " + results.Count);
        if (results.Count <= 0)
        {
            yield break;
        }
        float waittime = getAITime();
        Debug.Log("Ai will wait for " + waittime);
        yield return new WaitForSeconds(waittime);
        float extrawait = 0f;
        int startindex = Random.Range(0, results.Count - 1);
        for (int i = startindex; extrawait<=results.Count; i=(i+1)%results.Count)
        {
            if (checkLetterCountsInWord(results[i].ToString()))
            {
                extrawait = ai_speed * extrawait * 0.005f;
                Debug.Log("Extra wait for " + extrawait.ToString() + " for next AI prediction");
                yield return new WaitForSeconds(extrawait); // extra waiting for ai
                StartCoroutine(EnterWordFromAI(results[i].ToString(), end_index + 1));// end index + 1 will get the next wordbox. Here the end index was for the previous word
                Debug.Log("Completed AIGuess for start index = " + start_index.ToString());
                yield break;
            }
            extrawait += 1f;
        }
        Debug.Log("OUTSIDEFOR DONT COME!!!! Completed AIGuess for start index = " + start_index.ToString());
    }

    /*bool ok_word(string word)
    {
        foreach(string item in dictionary)
        {
            if (item == word)
            {
                return true;
            }
        }
        return false;
    }*/
    // Update is called once per frame
    void Update()
    {
        if (!solved&&!finish)
        {
            timer += Time.deltaTime;
            timerText.SetText(string.Format("{0:00}:{1:00}", Mathf.FloorToInt(timer / 60), Mathf.FloorToInt(timer % 60)));
            //Debug.Log(timer);
        }

    }
}
