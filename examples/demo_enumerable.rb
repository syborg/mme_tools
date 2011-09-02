# some tiny demos
# Marcel Massana 2-Sep-2011

require 'mme_tools/enumerable'
include MMETools::Enumerable

# compose
en1= [1, 2, 3, 4]
en2= ['a', 'b', 'c', 'd', 'e']
en3= {:elem1 => "1", :elem2 => "2", :elem3 => "3"}

p compose en1.dup, en2.dup, en3.dup
# => [[1, "a", [:elem1, "1"]], [2, "b", [:elem2, "2"]], [3, "c", [:elem3, "3"]], [4, "d", nil], [nil, "e", nil]]
p a1=compose(en2.dup, en1.dup) {|a,b| {a.to_sym => b}}
# => [{:a=>1}, {:b=>2}, {:c=>3}, {:d=>4}, {:e=>nil}]
p a1.inject({}) {|ac,item| ac.merge item}
# => {:b=>2, :d=>4, :e=>nil, :c=>3, :a=>1}
p a1.flatten
# => [{:a=>1}, {:b=>2}, {:c=>3}, {:d=>4}, {:e=>nil}]
p a2=compose(en2.dup, en1.dup).flatten
# => ["a", 1, "b", 2, "c", 3, "d", 4, "e", nil]
p Hash[*a2]
# => {"a"=>1, "b"=>2, "c"=>3, "d"=>4, "e"=>nil}
p a3=compose(en2.dup, en3.dup).flatten
# => ["a", :elem1, "1", "b", :elem2, "2", "c", :elem3, "3", "d", nil, "e", nil]

# classify
a1 = %w{ un dos tres quatre cinc sis set vuit nou deu }
a2 = <<EOF
petita petunia pestilent
calikenyo vigoros
plantunfula casualment rimbombant
pa amb tomata
pericó
EOF

p classify(a1) {|el| el[0..0]}
p classify(a1) {|el| el.length}
p classify(a2) {|el| el.count(" ")+1} # tb: el.count(" ")+1, el.split.size, el.scan(" ").size+1

# odd_values and even_values
p odd_values en1
# => [2, 4]
p even_values en1
# => [1, 3]