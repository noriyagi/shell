#wc��Ruby�Ԃ��쐬

ltotal = 0      #line
wtotal = 0      #word
ctotal = 0      #character

ARGV.each do |file|
  begin
    input = open(file)
    l = 0
    w = 0
    c = 0
    while line = input.gets   #line.gets ���@false �ɂȂ�܂�
      l += 1
      c += line.size
      line.sub!(/^\s+/,"")
      ary = line.split(/\s+/)
      w += ary.size
    end
   input.close
   printf("%8d %8d %8d %s\n", l, w, c, file) #printf�ŏo�͂𐮌`
   ltotal += l
   wtotal += w
   ctotal += c
  rescue => ex
    print ex.message, "\n"
  end
end
printf("%8d %8d %8d %s\n", ltotal, wtotal, ctotal, "total")