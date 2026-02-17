txd = engineLoadTXD("quad.txd")
engineImportTXD(txd, 1)
dff = engineLoadDFF("quad.dff", 1)
engineReplaceModel(dff, 1)



