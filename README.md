**これ古いんで使わないように．Bitbucket にある方を使いなさい． to me**

## 使い方

```
/some/where/lucy_01.iso
/some/where/lucy_02.iso
...
/some/where/lucy_12.iso
/some/where/annette_01.iso
...
/some/where/annette_12.iso
/some/where/annette_complete.iso
/some/where/katri_01.iso
...
/some/where/katri_12.iso
/some/where/katri_complete.iso
...
```

のようなファイル名で DVD の iso ファイルを準備する (complete は完結版)．

そして，

```
ruby execute.rb "/some/where" lucy | sh
```

のように実行する (第 1 引数に iso ファイルのあるディレクトリへのパス，第 2 引数に作品名)．

エンコードのために実行するべき HandBrakeCLI のコマンドが出力されるので，それを sh なり bash なりに食わせてやる．

## 備考

全作品，音量が小さいので --gain 12.0 を指定して音量を上げてある．

南の虹のルーシーは 1 巻を除いて音量が大きいため --gain 7.0 とする．

愛の若草物語はカラオケが 2 つあるためそのための分岐処理が存在する．

完結版を保持しているアルプス物語わたしのアンネットと牧場の少女カトリについてはそのエンコードのためのコマンドも生成する．

各話が，各巻の title 1 に OP, 本編，予告，ED，の 4 chapters で順番に収録されている．それに基づいてコマンド群を生成する．

最終巻の映像特典カラオケは title 2 の chapter 1 に収録されている．愛の若草物語は「若草の招待状」と「いつかきっと！」が title 2 と title 3 の chapter 1 にそれぞれ収録されている．

完結版は，title 1 にアバンタイトル，OP，本編，ED，予告，の 5 chapters で前編・後編が収録されている．

エンコード時のオプションは“か”の独自の好みで設定してある．
