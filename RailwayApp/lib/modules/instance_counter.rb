## Создать модуль InstanceCounter, содержащий следующие методы класса и инстанс-методы, которые подключаются
## автоматически при вызове include в классе:
## Методы класса:
##        - instances, который возвращает кол-во экземпляров данного класса
# Инстанс-методы:
#        - register_instance, который увеличивает счетчик кол-ва экземпляров класса и который можно вызвать из
#        конструктора. При этом данный метод не должен быть публичным.
# Подключить этот модуль в классы поезда, маршрута и станции.
## Примечание: инстансы подклассов могут считаться по отдельности, не увеличивая счетчик инстансов базового класса.
module InstanceCounter
  def self.included(base)
    base.include InstanceMethods
    base.extend ClassMethods
  end

  module ClassMethods
    attr_reader :instances

    def instances
      @instances ||= 0
    end

    def increase_instance
      @instances ||= 0
      @instances += 1
    end
  end

  module InstanceMethods
    protected

    def register_instance
      self.class.increase_instance
    end
  end
end
