oliveira = Station.create(name: 'Oliveira')
outeiro = Station.create(name: 'Outeiro')

Tank.create(station: oliveira, gasoline: 'S500', capacity: 30000)
Tank.create(station: oliveira, gasoline: 'S10', capacity: 15000)
Tank.create(station: oliveira, gasoline: 'GC', capacity: 15000)
Tank.create(station: oliveira, gasoline: 'ET', capacity: 10000)

Tank.create(station: outeiro, gasoline: 'GC', capacity: 30000)
Tank.create(station: outeiro, gasoline: 'GA', capacity: 15000)
Tank.create(station: outeiro, gasoline: 'ET', capacity: 15000)
Tank.create(station: outeiro, gasoline: 'S10', capacity: 15000)
Tank.create(station: outeiro, gasoline: 'S500', capacity: 15000)
