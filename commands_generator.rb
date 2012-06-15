class CommandsGenerator
  # 各作品の各巻に何話収録されているか
  Episodes = {
    lucy:         [5, 5, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4],
    annette:      [4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4],
    katri:        [5, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4],
    sara:         [5, 5, 4, 4, 4, 4, 4, 4, 4, 4, 4],
    pollyanna:    [5, 5, 5, 4, 4, 4, 4, 4, 4, 4, 4, 4],
    little_women: [4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4],
    cedie:        [5, 5, 5, 4, 4, 4, 4, 4, 4, 4],
  }

  def initialize(options)
    @production = options[:production]
    @episodes = Episodes[@production.to_sym]
    @path = options[:path] || ''
    generate_episodes_volumes_chapters
  end

  def execute
    commands = commands_for_main_stories
    commands += commands_for_karaoke
    if @production == 'annette' || @production == 'katri'
      commands += commands_for_complete
    end
    commands
  end

private
  # 要素が [話数, 収録巻, 開始チャプター] の配列を生成する
  # その配列を @episodes_volumes_chapters とする
  def generate_episodes_volumes_chapters
    begin_episodes_in_each_volume = @episodes.reduce([]) { |s, v|
      s << (s.last || 0) + v
    }.unshift(0)[0...-1]
    @episodes_volumes_chapters = []
    @episodes.each_with_index do |v, i|
      @episodes_volumes_chapters.concat((0...v).map { |j|
        [begin_episodes_in_each_volume[i] + j + 1, i + 1, 4 * j + 1]
      })
    end
  end

  def options(opt)
    "-f mp4 -q 7 -w 640 -l 480 --crop 0:0:0:0 -O --gain #{opt[:gain]}"
  end

  def commands_for_main_stories
    @episodes_volumes_chapters.reduce("") do |s, v|
      episode = format("%02d", v[0])
      volume = format("%02d", v[1])
      chapter = v[2]
      gain = ((@production == 'lucy' && volume != '01') ? '7.0' : '12.0')
      s + "HandBrakeCLI -i #{@path}/#{@production}_#{volume}.iso -o #{episode}.mp4 #{options(gain: gain)} -t 1 -c #{chapter}-#{chapter + 3}\n"
    end
  end

  def commands_for_karaoke
    if @production == 'lucy'
      "HandBrakeCLI -i #{@path}/#{@production}_#{@episodes.size}.iso -o karaoke.mp4 #{options(gain: '7.0')} -t 2 -c 1\n"
    elsif @production == 'little_women'
      "HandBrakeCLI -i #{@path}/#{@production}_#{@episodes.size}.iso -o karaoke0.mp4 #{options(gain: '12.0')} -t 2 -c 1\n" +
      "HandBrakeCLI -i #{@path}/#{@production}_#{@episodes.size}.iso -o karaoke1.mp4 #{options(gain: '12.0')} -t 3 -c 1\n"
    else
      "HandBrakeCLI -i #{@path}/#{@production}_#{@episodes.size}.iso -o karaoke.mp4 #{options(gain: '12.0')} -t 2 -c 1\n"
    end
  end

  def commands_for_complete
    "HandBrakeCLI -i #{@path}/#{@production}_complete.iso -o complete0.mp4 #{options(gain: '12.0')} -t 1 -c 1-5\n" +
    "HandBrakeCLI -i #{@path}/#{@production}_complete.iso -o complete1.mp4 #{options(gain: '12.0')} -t 1 -c 6-10\n"
  end
end
