require_relative 'Train'
require_relative 'Station'
require_relative 'Route'

st_klg = Station.new(:klg)
st_vln = Station.new(:vln)
st_mns = Station.new(:mns)
st_kzn = Station.new(:kzn)
st_ekb = Station.new(:ekb)
st_osk = Station.new(:osk)
st_nsb = Station.new(:nsb)
st_irk = Station.new(:irk)
st_hbr = Station.new(:hbr)
st_vdv = Station.new(:vdv)

st_msk = Station.new(:msk)

st_arh = Station.new(:arh)
st_vld = Station.new(:vld)
st_yar = Station.new(:yar)
st_tla = Station.new(:tla)
st_orl = Station.new(:orl)
st_krs = Station.new(:krs)
st_rnd = Station.new(:rnd)
st_knd = Station.new(:knd)
st_sci = Station.new(:sci)

route_1 = Route.new(st_klg, st_vdv)
route_2 = Route.new(st_arh, st_sci)

train_1 = Train.new('TRN-1', :crg, 20)
train_2 = Train.new('TRN-2', :psg, 10)
