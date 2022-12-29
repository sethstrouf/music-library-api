class LibraryPolicy < ApplicationPolicy
  def index?
    true
  end

  def create?
    true
  end

  def show?
    scope.where(id: record.id).exists?
    record.user == user
  end

  def update?
    true
  end

  def destroy?
    true
  end
end
