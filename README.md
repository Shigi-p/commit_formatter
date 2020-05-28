# commit_formatter
pythonでコミットメッセージのフォーマットを行うツールを作りました

## セットアップ

```shell script 
pip install -r requirements.txt
chmod +x setup_commit_formatter.sh
source ./setup_commit_formatter.sh
```

コマンドプロンプトとかの場合は`pip install`の部分を`py -m pip`とかでなんとかしてください

多分これすることで`gcommmit`で使用可能  
感覚的には`git commit`の感覚で使ってもらうと良いかも  

## 使用例

```shell script
git add file1 file2
gcommit
0 [add]    : ファイルの追加
1 [update] : コード・機能の追加
2 [fix]    : コード・機能の修正
3 [delete] : ファイルの削除
変更の種類を選択してください : 0
サマリーを入力してください : summary
詳細・理由を入力してください(入力しない場合はなし) : detail
[add] summary

detail 
```

`git add`してから`git commit`みたいな感覚でやって`git push`してください  
環境がbashじゃなくてgitbashで動くかどうかはわからないので試してみてください  
