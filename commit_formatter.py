#!/usr/bin/env python3
# _*_ coding: utf-8 _*_

import subprocess
from retry import retry


class Commit:
    def __init__(self):
        self.commit_type = self.decide_commit_type()
        self.summary = self.input_summary()
        self.detail = self.input_detail()

    @retry(ValueError)
    def decide_commit_type(self) -> str:
        print("0 [add]    : ファイルの追加")
        print("1 [update] : コード・機能の追加")
        print("2 [fix]    : コード・機能の修正")
        print("3 [delete] : ファイルの削除")
        print("変更の種類を選択してください : ", end="")
        commit_type = int(input())
        if commit_type == 0:
            return "[add]"
        elif commit_type == 1:
            return "[update]"
        elif commit_type == 2:
            return "[fix]"
        elif commit_type == 3:
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
        commit_message = self.commit_type + " " + self.summary
        if self.detail:
            commit_message += "\n" + "\n" + self.detail
        print(commit_message)
        return commit_message


if __name__ == "__main__":
    commit = Commit().create_commit_message()
    subprocess.run(['git', 'commit', '-m', commit])
