#!/usr/bin/env python3
# _*_ coding: utf-8 _*_

import subprocess
from retry import retry


class Commit:
    def __init__(self):
        self.commit_type = self.decide_commit_type()
        self.id = self.is_id();
        self.summary = self.input_summary()
        self.detail = self.input_detail()

    @retry(ValueError)
    def decide_commit_type(self) -> str:
        print("1 [add]     : ファイルの追加")
        print("2 [update]  : コード・機能の追加")
        print("3 [fix]     : コード・機能の修正")
        print("4 [refactor]: コードのリファクタリング")
        print("5 [document]: ドキュメント系の編集 ")
        print("6 [style]   : コードの動作に影響しない整形等")
        print("7 [delete]  : ファイルの削除")
        print("変更の種類を選択してください : ", end="")
        commit_type = int(input())
        if commit_type == 1:
            return "[add]"
        elif commit_type == 2:
            return "[update]"
        elif commit_type == 3:
            return "[fix]"
        elif commit_type == 4:
            return "[refactor]"
        elif commit_type == 5:
            return "[document]"
        elif commit_type == 6:
            return "[style]"
        elif commit_type == 7:
            return "[delete]"
        else:
            print("ERROR! 値が不正です")
            raise ValueError

    @retry(ValueError)
    def input_summary(self) -> str:
        print("サマリーを入力してください : ", end="")
        summary = input()
        if not summary:
            raise ValueError
        return summary

    @retry()
    def input_detail(self) -> str:
        print("詳細・理由を入力してください(入力しない場合はなし) : ", end="")
        detail = input()
        return detail

    def create_commit_message(self) -> str:
        commit_message = f'{self.commit_type} {self.id}{self.summary}'
        if self.detail:
            commit_message += "\n" + "\n" + self.detail
        print(commit_message)
        return commit_message

    @retry()
    def is_id(self) -> str:
        print("issueの番号・その他接頭辞として設定したいテキストを入力してください(入力しない場合はなし) : ", end="")
        id = input()
        if not id:
            return '';
        else:
            return f'#{id}:';


if __name__ == "__main__":
    commit = Commit().create_commit_message()
    subprocess.run(['git', 'commit', '-m', commit])
